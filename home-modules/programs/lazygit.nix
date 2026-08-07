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
          key = "R";
          description = "Create GitHub PR";
          context = "localBranches";
          command = ''
            git push -u origin {{.SelectedLocalBranch.Name}} &&
            gh pr create --base main --fill
          '';
          output = "terminal";
        }
      ];
    };
  };
}
