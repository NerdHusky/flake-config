# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:
# let
#   x = services.xserver.displayManager.session;
# in
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
      ./users.nix
      ./nvidia.nix
      
      (../../modules/fonts)
      
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
  services.xserver.displayManager.session = [
    {
      manage = "desktop";
      name = "awesome";
      start = "${pkgs.awesome}/bin/awesome";
    }
  ];
  # x = x ++ [
  #   {
  #     manage = "desktop";
  #     name = "awesome";
  #     start = "${pkgs.awesome}/bin/awesome";
  #   }
  # ];
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.lxqt.lxqt-openssh-askpass.out}/bin/lxqt-openssh-askpass";
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ### UNFREE
  nixpkgs.config.allowUnfree = true;
  
  # Nvidia dkms?!?
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.opengl.enable = true;
  # hardware.nvidia.modesetting.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    # helix
    neofetch
    pipes
    matrixcli
    killall
    # ripgrep
    git
    btop
    htop
    hdparm
    aria
    ranger
    tmux
    nix-index
    pciutils
    cudaPackages.cudatoolkit
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

 
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
    priority = 10;
    algorithm = "zstd";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

