# steam.nix

{ pkgs, lib, config, ... }: {

  options = {
    m_audio.enable = 
      lib.mkEnableOption "enables audio configuration";
  };

  config = lib.mkIf config.m_audio.enable {

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    # Enable sound with pipewire.
    #sound.enable = true;
    hardware.pulseaudio.enable = false;
    # make pipewire realtime-capable
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  };

}
