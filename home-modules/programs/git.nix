{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "pedromiguelvc";
        email = "108361383+pedromiguelvc@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";

      push = {
        autoSetupRemote = true;
        followTags = true;
        default = "current";
      };

      fetch.prune = true;

      rerere.enabled = true;

      help.autocorrect = 1;
      status = {
        branch = true;
        showStatus = true;
        showUntrackedFiles = "all";
      };

      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };

      pager = {
        stash = false;
        branch = false;
      };
      rebase = {
        autoStash = false;
        missingCommitsCheck = "warn";
        updateRefs = true;
      };

      core = {
        editor = "nvim";
        whitespace = "error";
        preloadindex = true;
      };

      advice = {
        addEmptyPathspec = false;
        pushNonFastForward = false;
        statusHints = false;
      };
    };
  };

  programs.delta = {
    enable = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = false;
      hyperlinks = true;
      hyperlinks-file-link-format = "file://{path}";
    };
  };

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
            gh pr create --fill
          '';
          output = "terminal";
        }
      ];
    };
  };

}
