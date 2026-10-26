#!/usr/bin/env bash
# Runs `nix flake update` and opens (or refreshes) one PR with the new
# flake.lock, listing every dev-shell tool whose version changes.
#
# Usage: update-flake-lock.sh            (needs GH_TOKEN, nix and a git checkout)
#        DRY_RUN=1 update-flake-lock.sh  (report only, changes nothing)
set -euo pipefail

BRANCH="deps/flake-lock"
TITLE="chore(flake): update flake.lock"
VERSIONS_ATTR=".#legacyPackages.x86_64-linux.packageVersions"
DRY_RUN="${DRY_RUN:-0}"

tool_versions() {
  nix eval --json "$VERSIONS_ATTR" | jq -r 'to_entries[] | "\(.key) \(.value)"' | sort -k1,1
}

nixpkgs_rev() {
  jq -r '.nodes.nixpkgs.locked.rev' flake.lock
}

old_versions=$(tool_versions)
old_rev=$(nixpkgs_rev)

nix flake update

if git diff --quiet flake.lock; then
  echo "flake.lock is already current"
  exit 0
fi

new_versions=$(tool_versions)
new_rev=$(nixpkgs_rev)

changes=$(join <(echo "$old_versions") <(echo "$new_versions") |
  awk '$2 != $3 { print "| `" $1 "` | " $2 " | " $3 " |" }')

if [ -n "$changes" ]; then
  version_table=$(printf '| Tool | Current | New |\n|---|---|---|\n%s' "$changes")
else
  version_table="No dev-shell tool changes version; only their dependencies were updated."
fi

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

if [ "$DRY_RUN" = "1" ]; then
  echo "[dry-run] would open $BRANCH with body:"
  echo "$body"
  exit 0
fi

git checkout -q -B "$BRANCH"
git commit -q -m "$TITLE" flake.lock
git push -q --force origin "$BRANCH"

pr=$(gh pr list --head "$BRANCH" --state open --json number --jq '.[0].number // empty')
if [ -n "$pr" ]; then
  gh pr edit "$pr" --body "$body"
else
  gh pr create --base main --head "$BRANCH" --title "$TITLE" --body "$body"
fi
