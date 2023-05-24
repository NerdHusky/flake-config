# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports =
    [ 
      ./pers.nix
      ./hardware-configuration.nix
      ./ephemereal.nix
      ./boot-kernel.nix
      ./sound.nix
      ./sops.nix
      ./virtualization.nix
      
      (../../modules/fonts)
      (../../modules/fish)
      
     inputs.home-manager.nixosModules.home-manager
    ];

  networking.hostName = "phoenix"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };
  
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  services.xserver.xkbOptions = "caps:escape";

  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.lxqt.lxqt-openssh-askpass.out}/bin/lxqt-openssh-askpass";
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ### UNFREE
  nixpkgs.config.allowUnfree = true;
  
  # Nvidia dkms?!?
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;


  ### Users  
  users.mutableUsers  = false;

  users.users.root = {
    passwordFile = config.sops.secrets.carlo-password.path;
    # initialHashedPassword = "$6$yr0XTMplnycxj3yW$bIsz5.OlrOBXTqR1jC6SneYEn5rT93OKcs0drrzo4/5YCSAbcv5KP1Eivec0vPuMcKEXURFeI.bJkPusy3AES.";
  };

  users.users.carlo = {
    # initialHashedPassword = "$6$yr0XTMplnycxj3yW$bIsz5.OlrOBXTqR1jC6SneYEn5rT93OKcs0drrzo4/5YCSAbcv5KP1Eivec0vPuMcKEXURFeI.bJkPusy3AES.";
    passwordFile = config.sops.secrets.carlo-password.path;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];   
    
    packages = with pkgs; [
      brave
      aichat
      tdesktop
      element-desktop
      gimp
      inkscape
      libreoffice-fresh
      mpv
      vlc
      alacritty
      kitty
      imv
      vlc
      smplayer
      qbittorrent
      vscode
      etcher
      # bootstrap-studio
      appimage-run
      glxinfo

      home-manager
    ];
  };
  # home-manager.users.carlo = import ../../home/carlo/phoenix.nix;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      carlo.imports = import ../../home/carlo/phoenix.nix;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    helix
    neofetch
    pipes
    matrixcli
    killall
    ripgrep
    git
    btop
    htop
    hdparm
    aria
    ranger
    tmux
    exa

    # xwayland

 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # services.openssh.settings.PermitRootLogin = "no";

  
  ### WIPE SCRIPT for Ephemereal BTRFS
  # Note `lib.mkBefore` is used instead of `lib.mkAfter` here.
  # boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
  #   mkdir -p /mnt

  #   # We first mount the btrfs root to /mnt
  #   # so we can manipulate btrfs subvolumes.
  #   mount -o subvol=/ /dev/md127 /mnt

  #   # While we're tempted to just delete /root and create
  #   # a new snapshot from /root-blank, /root is already
  #   # populated at this point with a number of subvolumes,
  #   # which makes `btrfs subvolume delete` fail.
  #   # So, we remove them first.
  #   #
  #   # /root contains subvolumes:
  #   # - /root/var/lib/portables
  #   # - /root/var/lib/machines
  #   #
  #   # I suspect these are related to systemd-nspawn, but
  #   # since I don't use it I'm not 100% sure.
  #   # Anyhow, deleting these subvolumes hasn't resulted
  #   # in any issues so far, except for fairly
  #   # benign-looking errors from systemd-tmpfiles.
  #   btrfs subvolume list -o /mnt/root |
  #   cut -f9 -d' ' |
  #   while read subvolume; do
  #     echo "deleting /$subvolume subvolume..."
  #     btrfs subvolume delete "/mnt/$subvolume"
  #   done &&
  #   echo "deleting /root subvolume..." &&
  #   btrfs subvolume delete /mnt/root

  #   echo "restoring blank /root subvolume..."
  #   btrfs subvolume snapshot /mnt/root-blank /mnt/root

  #   # Once we're done rolling back to a blank snapshot,
  #   # we can unmount /mnt and continue on the boot process.
  #   umount /mnt
  # '';




  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    # settings.max-jobs = 3;
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      carlo ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

  zramSwap = {
    enable = true;
    memoryPercent = 40;
    # numDevices = 1;
    priority = 10;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

