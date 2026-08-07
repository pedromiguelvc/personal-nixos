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
}
