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
              title = "PR title (empty to auto-fill from commits)";
            }
          ];
          command = ''
            git push -u origin {{.SelectedLocalBranch.Name}} &&
            gh pr create --base {{.Form.Base}} {{if .Form.Title}}--title "{{.Form.Title}}" --body ""{{else}}--fill{{end}}
          '';
          output = "log";
        }
      ];
    };
  };
}
