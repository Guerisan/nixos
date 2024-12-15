# steam.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_steam.enable = 
      lib.mkEnableOption "enables steam module";
  };

  config = lib.mkIf config.m_steam.enable {

    environment.systemPackages = with pkgs; [
      protonup
      r2modman
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true; # Start the games in an optimal microcompositor
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    programs.gamemode = {
      enable = true;
      settings = {
        general.renice = 10;
      };
    };
    programs.gamescope.capSysNice = false;
  };

  
}
