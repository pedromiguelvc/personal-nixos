{
  writeShellApplication,
  git,
  gh,
  jq,
  coreutils,
  gawk,
  hostname,
  util-linux, # provides `column`
}:

let
  mk =
    name: script:
    writeShellApplication {
      inherit name;
      runtimeInputs = [
        git
        gh
        jq
        coreutils
        gawk
        hostname
        util-linux
      ];
      text = builtins.readFile ./common.sh + builtins.readFile script;
    };
in
{
  preview = mk "preview-flake-update" ./preview.sh;
  pr = mk "update-flake-lock" ./update-flake-lock.sh;
}
