# plasma.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_plasma.enable = 
      lib.mkEnableOption "enables KDE plasma module";
  };

  config = lib.mkIf config.m_plasma.enable {

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      kwallet
      kwallet-pam
      kwalletmanager
      ktexteditor
    ];
    # Remplace un kwallet disfonctionnel
    services.gnome.gnome-keyring.enable = true;
  };

}
