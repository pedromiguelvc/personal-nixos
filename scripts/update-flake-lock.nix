{
  writeShellApplication,
  git,
  gh,
  jq,
  coreutils,
  gawk,
}:

writeShellApplication {
  name = "update-flake.lock";
  runtimeInputs = [
    git
    gh
    jq
    coreutils
    gawk
  ];
  text = builtins.readFile ./update-flake-lock.sh;
}
