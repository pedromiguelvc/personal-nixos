{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.carburauto = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

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

      apps.${system}.update-flake-lock = {
        type = "app";
        program = pkgs.lib.getExe (pkgs.callPackage ./scripts/update-flake-lock.nix { });
        meta.description = "Update flake.lock and open or refresh the dependency PR";
      };

      legacyPackages.${system}.packageVersions =
        let
          cfg = self.nixosConfigurations.carburauto.config;
          allPackages = cfg.environment.systemPackages ++ cfg.home-manager.users.carburauto.home.packages;
        in
        builtins.listToAttrs (
          map (p: {
            name = p.pname or p.name;
            value = p.version or "unknown";
          }) allPackages
        );
    };
}
