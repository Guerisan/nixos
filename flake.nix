{
  description = "NixOS Configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    nextcloud-client = {
      url = "github:nextcloud/desktop/v3.13.1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, stylix, nextcloud-client, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Définir l'overlay Nextcloud 
      nextcloudOverlay = final: prev: {
        nextcloud-client = prev.nextcloud-client.overrideAttrs (old: {
          version = "3.13.1";
          src = nextcloud-client;
        });
      };

    in {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            stylix.nixosModules.stylix
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ nextcloudOverlay ];
              environment.systemPackages = [ pkgs.nextcloud-client ];
            })
            # Vous pouvez ajouter d'autres modules ici si nécessaire
          ];
        };
      };

      # Vous pouvez ajouter d'autres outputs ici si nécessaire, par exemple :
      # devShell.${system} = ...
      # packages.${system} = ...
    };
}
