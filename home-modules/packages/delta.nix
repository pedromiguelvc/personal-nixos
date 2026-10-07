{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = false;
      hyperlinks = true;
      hyperlinks-file-link-format = "file://{path}";
    };
  };
}
