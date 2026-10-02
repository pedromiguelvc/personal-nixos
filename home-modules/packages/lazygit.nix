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
      };
      git.paging = [
        {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        }
      ];

      os.editPreset = "nvim";
      refresher.refreshInterval = 10;
      notARepository = "quit";
      customCommands = [
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
              suggestions = {
                preset = "branches";
              };
            }
            {
              type = "input";
              key = "Title";
              title = "PR type";
              options = [
                {
                  name = "(none)";
                  value = "";
                  description = "Write the title freely";
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
            }
            {
              type = "input";
              key = "Scope";
              title = "Scope (optional)";
              condition = "{{ .Form.Type }}";
            }
            {
              type = "input";
              key = "Title";
              title = "PR title (empty to auto-fill from commits)";
            }
          ];
          command = ''
            git push -u origin {{.SelectedLocalBranch.Name}} &&
            gh pr create --base {{.Form.Base}} {{if .Form.Title}}--title "{{.Form.Title}}" --body ""{{else}}--fill{{end}}
          '';
          output = "log";
        }
        {
          key = "<c-g>";
          description = "Conventional commit";
          context = "files";
          prompts = [
            {
              type = "menu";
              key = "Type";
              title = "Commit type";
              options = [
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
            }
            {
              type = "input";
              key = "Scope";
              title = "Scope (optional)";
              condition = "{{ .Form.Type }}";
            }
            {
              type = "input";
              key = "Message";
              title = "Commit message";
            }
          ];
          command = ''
            git commit -m {{ if .Form.Type }}{{ if .Form.Scope }}{{ printf "%s(%s): %s" .Form.Type .Form.Scope .Form.Message | quote }}{{ else }}{{ printf "%s: %s" .Form.Type .Form.Message | quote }}{{ end }}{{ else }}{{ .Form.Message | quote }}{{ end }}
          '';
          output = "log";
        }
      ];
    };
  };
}
