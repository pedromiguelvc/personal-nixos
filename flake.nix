{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
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

          nix-flatpak.nixosModules.nix-flatpak

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

      apps.${system} =
        let
          scripts = pkgs.callPackage ./scripts { };
          mkApp = description: drv: {
            type = "app";
            program = pkgs.lib.getExe drv;
            meta = { inherit description; };
          };
        in
        {
          update-flake-lock = mkApp "Update flake.lock and open the dependency PR" scripts.pr;
          preview-flake-update = mkApp "Preview package changes of a flake update" scripts.preview;
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
