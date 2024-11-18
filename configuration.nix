# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

 
  {

  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/asus/zephyrus/ga401>
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];


  ## Modules locaux activables
  m_steam.enable = true;
  m_stylix.enable = true;
  m_plasma.enable = false;
  m_hyprland.enable = true;
  #m_nixvim.enable = true;

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mitigations=off" "acpi_osi=Linux" ];

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Trim pour la maintenance et l'optimisation du ssd
  services.fstrim.enable = true;

  security.apparmor.enable = true;
  security.pam.services.swaylock = {};
  security.sudo.wheelNeedsPassword = false;

  # Perodic nix-store --optimise
  nix.optimise.automatic = true;

  networking.hostName = "JackdawNix"; # Define your hostname.

  networking.wireless.userControlled.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
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



 

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    xkb.variant = "";
  };

  # Prints a recap at the end of nixos-rebuild
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
     ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
           /run/current-system "$systemConfig"
    '';
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  
  # Apply GTK themes in wayland applications
  programs.dconf.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dl libs here
  ];

  virtualisation.docker.enable = true;

  # Enable driver for Radio SDR key
  hardware.rtl-sdr.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.realtime = {};
  users.users.jack = {
    isNormalUser = true;
    description = "Professeur Jack";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" "realtime" ];
    packages = with pkgs; [
      mangohud
      obsidian
      cmatrix
      gqrx
      discord
      spice
      gimp
      signal-desktop
      p7zip
      minetest
      hugo
      normcap
      gnuradio
      pulseview
      remmina
      cava
      figlet
      fastfetch
      urh
      multimon-ng
      tor-browser
      mapscii
      nextcloud-client
      asciinema
      asciiquarium-transparent
      drawio
      speedtest-cli
      axel
      qbittorrent
      # Cyber
      volatility3
      #ida-free
      burpsuite
      subfinder
      httpx
      nuclei
      nmap
      wireshark
      hydra-cli
      dig
      responder
      socat
    ];
  };



  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    montserrat
    lato
  ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "jack";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
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
    librewolf
    wget
    fish
    ripgrep
    eza
    bottom
    traceroute
    kitty
    kdePackages.kdeconnect-kde
    rtl-sdr-librtlsdr
    fzf
    pciutils
    usbutils
    protonup
    protontricks
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
    ffmpeg
    tcpflow
    xorg.xhost
    feh
    gnumake
    gparted
    pavucontrol
    wev # Find key codes
    brightnessctl
    bat
    killall
    lz4 # Lib for lampray mod manager
    wayland-utils
    vulkan-tools
    opencv
    ffmpegthumbs
    dxvk_2
    pipx

    #DE 
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

    # https://github.com/CachyOS/CachyOS-PKGBUILDS/blob/master/cachyos-gaming-meta/PKGBUILD
    giflib
    glfw
    libva
    libxslt
    ocl-icd
    openal

    nil # lsp language for nix-shells
    tcpdump
    perf-tools
    file
    asusctl
    supergfxctl
    sshfs
    yt-dlp
    nix-output-monitor # Tree visualisation on install
    
    wineWowPackages.stable
    winetricks
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];

 # nixpkgs.config.packageOverrides = pkgs: {
 #   nextcloud-client = pkgs.nextcloud-client.overrideAttrs (oldAttrs: {
 #     src = pkgs.fetchFromGitHub {
 #       # Fix nextcloud-client version
 #       owner = "nextcloud";
 #       repo = "desktop";
 #       rev = "v3.13.1";  
 #     };
 #   });
 # };

  services.ollama = {
    enable = false;
    acceleration = "cuda";
    host = "0.0.0.0"; 
    port = 11434;
    openFirewall = true;
  };

  services.asusd.enable = true;
  services.supergfxd.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
  };

  ## Virtualbox configuration
  virtualisation.virtualbox.host.enable = false;
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

  # services.openssh.enable = true;

  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 11434 5201 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
