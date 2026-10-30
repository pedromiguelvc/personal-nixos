{ pkgs, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  home.packages = [ pkgs.tuicr ];

  xdg.configFile."tuicr/config.toml".source = tomlFormat.generate "tuicr-config" {
    theme = "catppuccin-mocha";
    diff_view = "unified";
    scroll_offset = 5;
    leader = ";";
    comment_vim = false;
    q_quits = true;

    comment_types = [
      {
        id = "note";
        label = "question";
        definition = "ask for clarification";
        color = "yellow";
      }
      {
        id = "nit";
        label = "nitpick";
        definition = "small optional tweaks";
        color = "#d19a66";
      }
    ];

    forge.comment_type_prefix = false;
    export = {
      intro = "Please address these comments.";
      scope_line = false;
    };
  };
}
