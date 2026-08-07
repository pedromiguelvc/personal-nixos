{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland"; # ADD

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      ...
    }:
    {
      nixosConfigurations.carburauto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit hyprland; };

        modules = [
          ./configuration.nix

          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
            };

            home-manager.users.carburauto = import ./home.nix;
          }
        ];
      };
    };
}
