# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mitigations=off" ];

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_6_8;

  # Trim pour la maintenance et l'optimisation du ssd
  services.fstrim.enable = true;

  security.apparmor.enable = true;

  networking.hostName = "JackdawNix"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

    # Necessary for lsp in nvchad
    services.envfs.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  
  # Apply GTK themes in wayland applications
  programs.dconf.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dl libs here
    libfzf
  ];

  # Enable driver for Radio SDR key
  hardware.rtl-sdr.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack = {
    isNormalUser = true;
    description = "Professeur Jack";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    packages = with pkgs; [
      steam
      gamemode
      mangohud
      obsidian
      cmatrix
      gqrx
      urh
      discord
      spice
      gimp
      signal-desktop
      p7zip
      minetest
      hugo
      normcap
      simplex-chat-desktop
      # Cyber
      volatility3
      ida-free
      burpsuite
      subfinder
      httpx
      nuclei
      nmap
      wireshark
      onlyoffice-bin_latest
    ];
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # Start the games in an optimal microcompositor
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true; # Necessary addition to the gamemode package

  # Stylix styles (yaml themes generated with `nix build nixpkgs#base16-schemes`)
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

  stylix.targets.gtk.enable = true;

  stylix.image = ./my-cool-wallpaper.png;

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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];


  programs.neovim = {
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    defaultEditor = true;
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "jack";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xlsxgrep
    git
    wget
    nodejs
    unzip
    python312
    curl
    keepassxc
    powertop
    mpv
    gthumb
    firefox
    wget
    neofetch
    fish
    wine
    ripgrep
    eza
    bottom
    traceroute
    kitty
    touchegg
    nextcloud-client
    kdeconnect
    rtl-sdr-librtlsdr
    fzf
    pciutils
    usbutils
    protonup
    gcc
    xclip
    fd
    go
    openssl
    tree
    vim
    luajitPackages.jsregexp
    vimPlugins.vimtex
    pyright
    nixd
    perl
    cargo # gestionnaire de dépendances Rust
    libclang
    bluez
    gnuradio
    pulseview
    nil # lsp language for nix-shells
    tcpdump
    perf-tools
    kdePackages.qt6gtk2 # Fix incompatible qt lib mix
    # Python packages
    python312Packages.setuptools
    python312Packages.pip
    python312Packages.pyparsing
    python312Packages.future
    python312Packages.pynvim
    # Zephyrus G14
    asusctl
    supergfxctl
  ];

  services.ollama = {
    enable = false;
    acceleration = "cuda";
    host = "0.0.0.0"; 
    port = 11434;
    openFirewall = true;
  };

  services.asusd.enable = true;
  services.supergfxd.enable = true;


  environment.sessionVariables = rec {
    PYTHONPATH = "${pkgs.python3}/bin/python";
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };


  ## Virtualbox configuration
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "jack" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 11434 5201 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
