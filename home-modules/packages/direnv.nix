{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;

    config = {
      global = {
        strict_env = true;
        load_dotenv = true;
        warn_timeout = "10s";
      };
    };
  };

}
