{
  description = "NixOS Configuration with Flakes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, hyprland, hyprland-plugins, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # Ajout d'un overlay pour neovim unstable
          (final: prev: {
            neovim-unstable = inputs.nixpkgs.legacyPackages.${system}.neovim;
          })
        ];
      };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs pkgs;
        };
        modules = [
          ./configuration.nix
          ./modules/default.nix
          ./vbox.nix
          home-manager.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };
    };
}
