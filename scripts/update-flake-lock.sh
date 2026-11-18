BRANCH="deps/flake-lock"
TITLE="chore(flake): update flake.lock"
DRY_RUN="${DRY_RUN:-0}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

old_rev=$(nixpkgs_rev)

echo "Resolving latest inputs..."
resolve_new_lock "$tmp/flake.lock"

if cmp -s flake.lock "$tmp/flake.lock"; then
  echo "flake.lock is already current."
  exit 0
fi

new_rev=$(nixpkgs_rev "$tmp/flake.lock")

changes=$(
  compute_changes "$tmp/flake.lock" |
    awk '{ print "| `" $1 "` | " $2 " | " $3 " |" }'
)

if [ -n "$changes" ]; then
  version_table=$(printf \
    '| Package | Current | New |\n|---|---|---|\n%s' \
    "$changes")
else
  version_table="No package changes version; only their dependencies were updated."
fi

# Generate PR description.
body=$(cat <<EOF
Bumps the flake inputs to their latest revisions.

## Package versions

$version_table

nixpkgs: [\`${old_rev:0:12}...${new_rev:0:12}\`](https://github.com/NixOS/nixpkgs/compare/$old_rev...$new_rev)

## Before merging

- [ ] Check out this branch and run \`nixos-rebuild build --flake .#carburauto\` to confirm the system still builds.

Opened by \`.github/workflows/update-flake-lock.yml\`.
EOF
)

# Dry run: report changes without modifying anything.
if [ "$DRY_RUN" = "1" ]; then
  echo "[dry-run] Would open/update PR for $BRANCH"
  echo
  echo "$body"
  exit 0
fi

# Apply the update only now, so a dry run never touches the working tree.
cp "$tmp/flake.lock" flake.lock

echo "Checking GitHub authentication..."
gh auth status

echo "Preparing branch $BRANCH..."
git checkout -q -B "$BRANCH"
git add flake.lock
git commit -q -m "$TITLE"

echo "Pushing branch..."
git push -q --force origin "$BRANCH"

REPO="${GITHUB_REPOSITORY:-$(gh repo view --json nameWithOwner --jq '.nameWithOwner')}"

echo "Checking for existing pull requests..."
pr=$(
  gh pr list \
    --repo "$REPO" \
    --head "$BRANCH" \
    --state open \
    --json number \
    --jq '.[0].number // empty'
)

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
