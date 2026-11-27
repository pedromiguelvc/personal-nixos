{
  programs.tuicr = {
    enable = true;

    settings = {
      theme = "tokyo-night-storm";
      diff_view = "unified";
      ignore_whitespace = false;
      appearance = "system";
      mouse = true;
      leader = ";";
      editor = "nvim";
      comment_vim = false;
      relative_line_numbers = false;
      show_pr_checks = true;
      no_update_check = true;
      q_quits = true;
    };
  };
}
