{ config, ... }:
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      show-icons = true;
      modes = "window,drun,recursivebrowser";

      sort = true;
      sorting-method = "fzf";
      matching = "fuzzy";
      case-smart = true;
      normalize-match = true;

      cycle = true;
      hover-select = false;
      auto-select = false;

      threads = 0;
      max-history-size = 50;

      window-match-fields = "title,class,name";
      window-format = "{t}";
      window-thumbnail = true;

      drun-match-fields = "name,generic,exec,keywords";
      drun-display-format = "{name}";
      drun-show-actions = true;
      drun-use-desktop-cache = true;

      application-fallback-icon = "application-x-executable";

      kb-clear-line = "Control+w";
      kb-move-front = "Control+i";
      kb-move-end = "Control+a";
      kb-remove-word-back = "Control+BackSpace";

      combi-hide-mode-prefix = true;

      timeout = {
        action = "kb-cancel";
        delay = 0;
      };

      filebrowser = {
        directory = "~";
        directories-first = true;
        sorting-method = "name";
      };

      recursivebrowser = {
        directories-first = true;
        sorting-method = "name";
        command = "xdg-open";
      };
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg0 = mkLiteral "#1a1b26";
          bg1 = mkLiteral "#24283b";
          bg-sel = mkLiteral "#283457";
          fg0 = mkLiteral "#c0caf5";
          fg1 = mkLiteral "#a9b1d6";

          blue = mkLiteral "#7aa2f7";
          cyan = mkLiteral "#7dcfff";
          purple = mkLiteral "#bb9af7";
          green = mkLiteral "#9ece6a";
          red = mkLiteral "#f7768e";
          border-col = mkLiteral "#7aa2f7";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";
          font = mkLiteral "\"JetBrainsMono Nerd Font 11\"";

          margin = 0;
          padding = 0;
          spacing = 0;
        };

        window = {
          background-color = mkLiteral "@bg0";
          border = 2;
          border-color = mkLiteral "@border-col";
          border-radius = 12;
          width = 640;
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          padding = 0;
        };

        mainbox = {
          padding = 12;
          spacing = 10;
          children = map mkLiteral [
            "inputbar"
            "message"
            "listview"
          ];
        };

        inputbar = {
          background-color = mkLiteral "@bg1";
          border-radius = 8;
          padding = mkLiteral "10px 14px";
          spacing = 10;
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
        };

        prompt = {
          text-color = mkLiteral "@blue";
          vertical-align = mkLiteral "0.5";
        };

        entry = {
          placeholder = "Search...";
          placeholder-color = mkLiteral "@fg1";
          text-color = mkLiteral "@fg0";
          vertical-align = mkLiteral "0.5";
          cursor = mkLiteral "text";
        };

        message = {
          background-color = mkLiteral "@bg1";
          border-radius = 8;
          padding = mkLiteral "8px 12px";
        };

        textbox = {
          text-color = mkLiteral "@fg1";
        };

        listview = {
          background-color = mkLiteral "transparent";
          columns = 1;
          lines = 8;
          fixed-height = false;
          cycle = true;
          dynamic = true;
          scrollbar = true;
          spacing = 4;
          padding = mkLiteral "4px 0px";
        };

        scrollbar = {
          background-color = mkLiteral "@bg1";
          handle-color = mkLiteral "@blue";
          handle-width = 6;
          border-radius = 4;
          padding = mkLiteral "0px 2px";
        };

        element = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg1";
          border-radius = 8;
          padding = mkLiteral "9px 12px";
          spacing = 10;
          cursor = mkLiteral "pointer";
        };

        "element normal.normal" = {
          text-color = mkLiteral "@fg0";
        };

        "element normal.urgent" = {
          text-color = mkLiteral "@red";
        };

        "element normal.active" = {
          text-color = mkLiteral "@cyan";
        };

        "element selected.normal" = {
          background-color = mkLiteral "@bg-sel";
          text-color = mkLiteral "@blue";
        };

        "element selected.urgent" = {
          background-color = mkLiteral "@bg-sel";
          text-color = mkLiteral "@red";
        };

        "element selected.active" = {
          background-color = mkLiteral "@bg-sel";
          text-color = mkLiteral "@cyan";
        };

        "element alternate.normal" = {
          text-color = mkLiteral "@fg0";
        };

        element-icon = {
          background-color = mkLiteral "transparent";
          size = mkLiteral "1.1em";
          vertical-align = mkLiteral "0.5";
        };

        element-text = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
        };
      };
  };
}
