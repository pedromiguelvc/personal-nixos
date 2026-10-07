{ ... }:

let
  typeOptions = [
    {
      name = "(none)";
      value = "";
      description = "Write the message freely";
    }
    {
      name = "feat";
      value = "feat";
      description = "A new feature";
    }
    {
      name = "fix";
      value = "fix";
      description = "A bug fix";
    }
    {
      name = "docs";
      value = "docs";
      description = "Documentation only";
    }
    {
      name = "style";
      value = "style";
      description = "Formatting, no logic change";
    }
    {
      name = "refactor";
      value = "refactor";
      description = "Restructuring, no behavior change";
    }
    {
      name = "perf";
      value = "perf";
      description = "Performance improvement";
    }
    {
      name = "test";
      value = "test";
      description = "Add or correct tests";
    }
    {
      name = "build";
      value = "build";
      description = "Build system or dependencies";
    }
    {
      name = "ci";
      value = "ci";
      description = "CI/CD configuration";
    }
    {
      name = "chore";
      value = "chore";
      description = "Routine maintenance";
    }
    {
      name = "revert";
      value = "revert";
      description = "Revert a previous commit";
    }
  ];

  typePrompt = title: {
    type = "menu";
    key = "Type";
    inherit title;
    options = typeOptions;
  };

  scopePrompt = {
    type = "input";
    key = "Scope";
    title = "Scope (optional)";
    condition = "{{ .Form.Type }}";
  };

  mkSubject =
    field:
    ''{{ if .Form.Type }}{{ if .Form.Scope }}{{ printf "%s(%s): %s" .Form.Type .Form.Scope .Form.${field} | quote }}{{ else }}{{ printf "%s: %s" .Form.Type .Form.${field} | quote }}{{ end }}{{ else }}{{ .Form.${field} | quote }}{{ end }}'';
in

{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        border = "rounded";
        showIcons = true;
        expandFocusedSidePanel = true;
        showPanelJumps = true;
        showBottomLine = true;
        showCommandLog = true;
        nerdFontsVersion = "3";
        showRandomTip = false;
      };

      git = {
        mainBranches = [
          "main"
          "master"
        ];
        paging = [
          {
            colorArg = "always";
            pager = ''delta --paging=never --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"'';
          }
        ];
      };

      os.editPreset = "nvim";
      refresher.refreshInterval = 10;
      notARepository = "quit";
      update.method = "never"; # updates are managed by Nix

      customCommands = [
        {
          key = "<c-g>";
          description = "Conventional commit";
          context = "files";
          prompts = [
            (typePrompt "Commit type")
            scopePrompt
            {
              type = "input";
              key = "Message";
              title = "Commit message";
            }
          ];
          command = "git commit -m ${mkSubject "Message"}";
          output = "log";
        }

        {
          key = "<c-r>";
          description = "Create GitHub PR";
          context = "localBranches";
          prompts = [
            {
              type = "input";
              key = "Base";
              title = "Base branch";
              initialValue = "main";
              suggestions.preset = "branches";
            }
            {
              type = "menu";
              key = "Draft";
              title = "PR state";
              options = [
                {
                  name = "Ready";
                  value = "";
                  description = "Open as ready for review";
                }
                {
                  name = "Draft";
                  value = "--draft";
                  description = "Open as a draft";
                }
              ];
            }
            (typePrompt "PR type")
            scopePrompt
            {
              type = "input";
              key = "Title";
              title = "PR title (empty to auto-fill from commits)";
            }
          ];
          command = ''
            git push -u origin {{ .SelectedLocalBranch.Name }} &&
            gh pr create --base {{ .Form.Base }} {{ .Form.Draft }} {{ if .Form.Title }}--title ${mkSubject "Title"} --body ""{{ else }}--fill{{ end }}
          '';
          output = "log";
        }
      ];
    };
  };
}
