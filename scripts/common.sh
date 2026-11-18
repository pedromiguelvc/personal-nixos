VERSIONS_ATTR=".#legacyPackages.x86_64-linux.packageVersions"

# Prints "name version" for every package. Extra arguments go to `nix eval`.
tool_versions() {
  nix eval --json "$@" "$VERSIONS_ATTR" |
    jq -r 'to_entries[] | "\(.key) \(.value)"' |
    sort -k1,1
}

# Prints the nixpkgs revision of a lock file (defaults to ./flake.lock).
nixpkgs_rev() {
  jq -r '.nodes.nixpkgs.locked.rev' "${1:-flake.lock}"
}

# Writes the would-be updated lock file to $1 without touching flake.lock.
resolve_new_lock() {
  nix flake update --output-lock-file "$1"
}

# Prints "name old new" for each package whose version differs.
compute_changes() {
  local new_lock=$1
  join -a 1 -a 2 -e "-" -o 0,1.2,2.2 \
    <(tool_versions) \
    <(tool_versions --reference-lock-file "$new_lock") |
    awk '$2 != $3'
}
