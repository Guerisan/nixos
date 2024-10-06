# Default.nix Only is used to import all other modules

{ pkgs, lib, config, ... }: {

  imports = [
  ./steam.nix
  ./stylix.nix
  ./audio.nix
  ./plasma.nix
  ./hyprland.nix
  ];

}
