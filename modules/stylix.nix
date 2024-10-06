# steam.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_stylix.enable = 
      lib.mkEnableOption "enables stylix module";
  };

  config = lib.mkIf config.m_stylix.enable {
    # Stylix styles (yaml themes generated with `nix build nixpkgs#base16-schemes`)
    stylix.enable = true;
    stylix.autoEnable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    stylix.targets.gtk.enable = true;

    stylix.image = /home/jack/Medias/Wallpapers/rain-forest-wallpaper.jpg;

    #stylix.fonts.sizes = {
    #  applications = 12;
    #  terminal = 15;
    #  desktop = 10;
    #  popups = 10;
    #};

    stylix.opacity = {
      applications = 1.0;
      terminal = .85;
      desktop = 1.0;
      popups = 1.0;
    };
    
    #stylix.polarity = "dark" # "light" or "either"

  };

}
