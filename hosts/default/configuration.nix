{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/default.nix
      inputs.home-manager.nixosModules.default
    ];

  # State Version
  system.stateVersion = "23.11";

  # Bootloader
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    configurationLimit = 32;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Clean system
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # Network
  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Time
  time.timeZone = "Europe/Berlin";

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Keymap (X11)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Main User
  main-user.enable = true;
  main-user.userName = "michi";

  # AutoLogin
  services.getty.autologinUser = "michi";

  # Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # System Packages (Search with: nix search <package>)
  environment.systemPackages = with pkgs; [
    android-tools
    blender
    catppuccin
    catppuccin-gtk
    catppuccin-papirus-folders
    dolphin
    firefox
    fusee-nano
    gamemode
    gamescope
    gcc
    gimp
    git
    gparted
    hello
    heroic
    hyprshot
    inkscape
    jdk
    kitty
    krita
    libnotify
    mako
    mangohud
    mari0
    minecraft
    minecraft-server
    mpv
    nerdfonts
    neofetch
    nodejs
    obs-studio
    openrgb
    papermc
    papirus-icon-theme
    pavucontrol
    rofi
    rofimoji
    spotify
    steam
    superTuxKart
    swww
    unzip
    ventoy
    waybar
    webcord-vencord
    wev
    weylus
    wget
  ];

  nixpkgs.config.permittedInsecurePackages = [
    ""
  ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "michi" = import ./home.nix;
    };
  };

  # Display Manager + NVidia
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  
  # XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Audio / Sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # OBS Virtual Cam
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true; 

  # Shell
  programs.zsh.enable = true; 

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts 
  ];

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Persist
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
