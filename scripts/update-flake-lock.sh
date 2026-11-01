```bash
#!/usr/bin/env bash
# Runs `nix flake update` and opens (or refreshes) one PR with the new
# flake.lock, listing every dev-shell tool whose version changes.
#
# Usage:
#   update-flake-lock.sh
#   DRY_RUN=1 update-flake-lock.sh
#
# Requires: GH_TOKEN, nix, git, gh, jq, coreutils, gawk

set -euo pipefail

BRANCH="deps/flake-lock"
TITLE="chore(flake): update flake.lock"
VERSIONS_ATTR=".#legacyPackages.x86_64-linux.packageVersions"
DRY_RUN="${DRY_RUN:-0}"

tool_versions() {
  nix eval --json "$VERSIONS_ATTR" |
    jq -r 'to_entries[] | "\(.key) \(.value)"' |
    sort -k1,1
}

nixpkgs_rev() {
  jq -r '.nodes.nixpkgs.locked.rev' flake.lock
}

# Capture current versions before updating.
echo "Reading current package versions..."
old_versions=$(tool_versions)
old_rev=$(nixpkgs_rev)

# Update all flake inputs.
echo "Updating flake inputs..."
nix flake update

# Stop if nothing changed.
if git diff --quiet -- flake.lock; then
  echo "flake.lock is already current."
  exit 0
fi

# Capture new versions.
echo "Reading updated package versions..."
new_versions=$(tool_versions)
new_rev=$(nixpkgs_rev)

# Compare package versions, including added and removed packages.
changes=$(
  join -a 1 -a 2 -e "-" \
    <(echo "$old_versions") \
    <(echo "$new_versions") |
    awk '$2 != $3 {
      print "| `" $1 "` | " $2 " | " $3 " |"
    }'
)

if [ -n "$changes" ]; then
  version_table=$(printf \
    '| Tool | Current | New |\n|---|---|---|\n%s' \
    "$changes")
else
  version_table="No dev-shell tool changes version; only their dependencies were updated."
fi

# Generate PR description.
body=$(cat <<EOF
Bumps the flake inputs to their latest revisions.

## Dev-shell tool versions

$version_table

nixpkgs: [\`${old_rev:0:12}...${new_rev:0:12}\`](https://github.com/NixOS/nixpkgs/compare/$old_rev...$new_rev)

## Before merging

- [ ] Check out this branch, run \`nix develop\` and confirm the shell still builds.

Opened by \`.github/workflows/update-flake-lock.yml\`.
EOF
)

# Dry run: report changes without modifying GitHub.
if [ "$DRY_RUN" = "1" ]; then
  echo "[dry-run] Would open/update PR for $BRANCH"
  echo
  echo "$body"
  exit 0
fi

# Check GitHub authentication.
echo "Checking GitHub authentication..."
gh auth status

# Create/update branch.
echo "Preparing branch $BRANCH..."
git checkout -q -B "$BRANCH"

git add flake.lock
git commit -q -m "$TITLE"

# Push updated branch.
echo "Pushing branch..."
git push -q --force origin "$BRANCH"

# Identify repository.
REPO="${GITHUB_REPOSITORY:-$(gh repo view --json nameWithOwner --jq '.nameWithOwner')}"

# Find existing PR.
echo "Checking for existing pull requests..."

pr=$(
  gh pr list \
    --repo "$REPO" \
    --head "$BRANCH" \
    --state open \
    --json number \
    --jq '.[0].number // empty'
)

# Create or update PR.
if [ -n "$pr" ]; then
  echo "Updating existing PR #$pr..."
  gh pr edit "$pr" \
    --repo "$REPO" \
    --body "$body"
else
  echo "Creating new pull request..."

  gh pr create \
    --repo "$REPO" \
    --base main \
    --head "$BRANCH" \
    --title "$TITLE" \
    --body "$body"
fi

echo "Done!"
```
