tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

echo "Resolving latest inputs (flake.lock is not modified)..."
resolve_new_lock "$tmp/flake.lock"

if cmp -s flake.lock "$tmp/flake.lock"; then
  echo "flake.lock is already current."
  exit 0
fi

echo
echo "nixpkgs: $(nixpkgs_rev | cut -c1-12) -> $(nixpkgs_rev "$tmp/flake.lock" | cut -c1-12)"
echo
echo "Packages that would change:"
compute_changes "$tmp/flake.lock" |
  awk '{ printf "%s %s -> %s\n", $1, $2, $3 }' |
  column -t
