# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, outputs, ... }:
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
  # services.xserver.xkbOptions = "caps:escape";

  # services.xserver.displayManager.gdm.enable = true;
  
	# services.xserver.windowManager.qtile = {
	# 	enable = true;
	# 	package = pkgs.qtile;
	# 	configFile = /home/carlo/.config/qtile/config.py;
	# }; 
 #  services.xserver.displayManager.session = [
 #    {
 #      manage = "desktop";
 #      name = "qtile";
 #      start = "${pkgs.qtile}/bin/qtile";
 #    }
 #  ];
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.lxqt.lxqt-openssh-askpass.out}/bin/lxqt-openssh-askpass";
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # services.printing.enable = true;
  # services.avahi.enable = true;
  # services.avahi.nssmdns = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      samsung-unified-linux-driver
      splix
    ];
  };

  # services.hardware.xow.enable = true;
  hardware.bluetooth.enable = true;
  hardware.xpadneo.enable = true;

  ### UNFREE
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
  
  # systemd.services.nixos-upgrade.path = [ pkgs.git ];

  # Nvidia dkms?!?
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.opengl.enable = true;
  # hardware.nvidia.modesetting.enable = true;
  services.udev.packages = with pkgs; [
    vial
    via
  ];

  nixpkgs.config.permittedInsecurePackages = [
      # "python-2.7.18.6"
  #   "electron-12..3"
     "freeimage-unstable-2021-11-01"
  ];


  environment.systemPackages = with pkgs; [
    git
    # cudaPackages.cudatoolkit
    linuxKernel.packages.linux_xanmod_stable.nvidia_x11_stable_open
    pkgs.linuxKernel.packages.linux_xanmod_stable.openrazer
    zram-generator
    # electron_22
    python311
    python311Packages.pip
    # mongodb
   ];
  
  environment.sessionVariables = {
    # MOZ_ENABLE_WAYLAND = "1";
    # QT_QPA_PLATFORM = "wayland";
    # LIBSEAT_BACKEND = "logind";
	  # LIBVA_DRIVER_NAME = "nvidia";
		# XDG_SESSION_TYPE = "wayland";
		# GBM_BACKEND = "nvidia-drm";
		# __GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    # GDK_BACKEND = "x11";
  };

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
   
  services.ratbagd.enable = true;
  # services.openssh.settings.PermitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

 
  # nix = {
  #   package = pkgs.nixFlakes;
  #   environment.systemPackages = with pkgs; [
  #   git
  #   # cudaPackages.cudatoolkit
  #   linuxKernel.packages.linux_xanmod_stable.nvidia_x11_stable_open
  #   pkgs.linuxKernel.packages.linux_xanmod_stable.openrazer
  #   zram-generator
  #   # electron_22
  #   python311
  #   python311Packages.pip
  #   # mongodb
  #  ];
  # };
  
  # environment.sessionVariables = {
  #   # MOZ_ENABLE_WAYLAND = "1";
  #   # QT_QPA_PLATFORM = "wayland";
  #   # LIBSEAT_BACKEND = "logind";
	#   # LIBVA_DRIVER_NAME = "nvidia";
	# 	# XDG_SESSION_TYPE = "wayland";
	# 	# GBM_BACKEND = "nvidia-drm";
	# 	# __GLX_VENDOR_LIBRARY_NAME = "nvidia";
	# 	WLR_NO_HARDWARE_CURSORS = "1";
  #   NIXOS_OZONE_WL = "1";
  #   # GDK_BACKEND = "x11";
  # };

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
   
  # services.ratbagd.enable = true;
  # services.openssh.settings.PermitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

 
  # nix = {
  #   package = pkgs.nixFlakes;
  #   extraOptions = "experimental-features = nix-command flakes";
  #   # settings.max-jobs = 3;
  # };

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

programs.hyprland = { # we use this instead of putting it in systemPackages/users  
    enable = true;  

    # package = inputs.hyprland.packages.${pkgs.system}.default;
    xwayland.enable = true;  
    # nvidiaPatches = true; # ONLY use this line if you have an nvidia card  
    package = inputs.hyprland.packages.${pkgs.system}.default;
    # extraConfig =
      # (import ./monitors.nix {
      #   inherit lib;
      #   inherit (config) monitors;
      # }) +
      # (import ./config.nix {
      #   inherit (config) home colorscheme;
      # });
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

