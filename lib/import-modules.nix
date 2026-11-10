dir:

let
  entries = builtins.readDir dir;

  isModule =
    name: type:
    (type == "regular" && builtins.match ".*\\.nix" name != null)
    || (type == "directory" && builtins.pathExists (dir + "/${name}/default.nix"));

  modules = builtins.filter (name: name != "default.nix" && isModule name entries.${name}) (
    builtins.attrNames entries
  );

in
map (name: dir + "/${name}") modules
