{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.carburauto = {
    isNormalUser = true;
    description = "Carburauto";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$s4P3jxQX1gZ2k5K6$7C/lXXaf59w/S4g1.0yfKLC1tBbstuCHiBpvhM6RUKejA/nfzIrvtEPXSB5.jqfaVKgXprpB6DmGwZsFsOR6.0";
    shell = pkgs.zsh;
  };

}
