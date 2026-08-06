{
  pkgs,
  ...
}:

{
  home.file.".config/zsh".source = ./config/zsh;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    shellAliases = {
      ns = "sudo nixos-rebuild switch --flake ~/nixos#$(hostname)";
      nd = "nix develop";
      nst = "sudo nixos-rebuild test --flake ~/nixos#$(hostname)";
      nsb = "sudo nixos-rebuild build --flake ~/nixos#$(hostname)";
      nsu = "nix flake update ~/nixos";

      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --group-directories-first";
      la = "eza -lha --icons --group-directories-first";

      tree = "eza --tree --icons";
      cat = "bat --paging=never";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      rm = "trash-put";
      v = "nvim";
      t = "tmux";
      tl = "tmux ls";
      tk = "tmux kill-session -t";
      tks = "tmux kill-server";
      ta = "tmux attach";

      gs = "git status -s";
      gss = "git status";
      gc = "git commit -m";
      gp = "git push";
      gsh = "git stash";
      gl = "git pull";
      glm = "git pull origin $(git_main_branch)";
      gk = "git checkout";
      glgg = "git log --oneline --graph --all --decorate";
      gdff = "git diff --output-indicator-new='+' --output-indicator-old='-'";
      lg = "lazygit";

      # docker
      d = "docker";
      dl = "docker logs";
      dc = "docker compose";
      dcu = "docker compose up";
      dcub = "docker compose up --build";
      dcd = "docker compose down";
      dp = ''docker ps --format "table {{.Status}}\t{{.ID}}\t{{.Names}}"'';
      dpp = ''docker ps --format "table {{.Status}}\t{{.ID}}\t{{.Names}}\t{{.Ports}}"'';
      dpa = ''docker ps -a --format "table {{.Status}}\t{{.ID}}\t{{.Names}}"'';
    };

    shellGlobalAliases = {
      J = "| jq";
      C = "| wl-copy";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
        "docker"
        "docker-compose"
        "aws"
      ];

    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      bindkey -v
      source ~/.config/zsh/functions.zsh
      source ~/.config/zsh/p10k.zsh
    '';
  };
}
