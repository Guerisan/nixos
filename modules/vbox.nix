# vbox.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_vbox.enable = 
      lib.mkEnableOption "enables Virtualbox module";
  };

  config = lib.mkIf config.m_vbox.enable {
    
    ## Virtualbox configuration
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "jack" ];
    virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation.virtualbox.guest.enable = true;

  };

}