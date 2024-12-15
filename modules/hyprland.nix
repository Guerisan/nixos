# hyprland.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_hyprland.enable = 
      lib.mkEnableOption "enables hyprland module";
  };

  config = lib.mkIf config.m_hyprland.enable {

    environment.systemPackages = with pkgs; [
      waybar
      dunst
      libnotify
      swww
      rofi-wayland
      networkmanagerapplet
      grim # Screeshot utility
      slurp # Select utility
      wl-clipboard # xclip alternative
      swaylock-effects
      bibata-cursors
      brightnessctl
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      #package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    # file manager
    programs.thunar.enable = true;
    programs.xfconf.enable = true;

    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images


    environment.sessionVariables = {
#If your cursor becomes invisible
      #WLR_NO_HARDWARE_CURSORS = "1";
#Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

  };

}


