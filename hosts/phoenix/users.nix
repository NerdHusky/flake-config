{config, inputs, outputs, pkgs, ...}:

let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  ### IMPORTANT IF WANT TO USE OVERLAYS!!
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
  ### Users  
  users.mutableUsers  = false;

  users.users.root = {
    hashedPasswordFile = config.sops.secrets.carlo-password.path;
    # initialHashedPassword = "$6$yr0XTMplnycxj3yW$bIsz5.OlrOBXTqR1jC6SneYEn5rT93OKcs0drrzo4/5YCSAbcv5KP1Eivec0vPuMcKEXURFeI.bJkPusy3AES.";
  };

  users.users.carlo = {
    # initialHashedPassword = "$6$yr0XTMplnycxj3yW$bIsz5.OlrOBXTqR1jC6SneYEn5rT93OKcs0drrzo4/5YCSAbcv5KP1Eivec0vPuMcKEXURFeI.bJkPusy3AES.";
    hashedPasswordFile = config.sops.secrets.carlo-password.path;
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
      google-chrome
      librewolf
      microsoft-edge
      aichat
      tdesktop
      element-desktop
      meld
      gimp
      gparted
      inkscape
      libreoffice-fresh
      wpsoffice
      calibre
      mpv
      vlc
      kitty
      imv
      vlc
      smplayer
      qbittorrent
      vscode
      jetbrains.webstorm
      jetbrains.goland
      # etcher
      unetbootin
      usbimager
      bootstrap-studio
      appimage-run
      glxinfo
      authy
      gnome.gnome-tweaks
      nix-prefetch
      nix-prefetch-git
      # picom-pijulius
      # picom-jonaburg
      # python311Packages.ewmh
      xorg.xhost
      qmk
      powerline
      distrobox
      # oni2
      # nodePackages.esy # to compile onivim
      # nasm # idem
      # nodePackages.node-gyp #idem
      # ( lutris.override { 
      #   extraPkgs = pkgs : [
      #     wineWowPackages.full
      #     winetricks
      #   ]; 
      #   }
      # )
      lutris
      wineWowPackages.full
      winetricks
      mangohud

      piper
      # libratbagd

      bitwarden
      discord

      # plover.dev
    #  winePackages.staging

      pulseaudio
      pavucontrol

      freecad
      openscad

      teamviewer
      # vial
      # cairo
      # gnumake42
      # cmake
      # gccgo
      # lua
      # luarocks
      # awesome

      xorg.xdpyinfo # Maybe for distrobox kali airgeddon to work?
      
      airgeddon
      aircrack-ng
      coreutils-full
      ntfs3g
      curl
      gawk
      glibc
      gnugrep
      gnused
      iproute2
      iw
      ncurses
      procps
      usbutils
      ethtool
      util-linux
      ccze
      bully
      pixiewps
      reaverwps-t6x
      asleap
      crunch
      hashcat
      hcxdumptool
      hcxtools
      john
      wireshark-cli
      bettercap
      # dhcp
      dnsmasq
      ettercap
      hostapd
      lighttpd
      openssl
      mdk4
      nftables
      apparmor-bin-utils
      xterm
      xorg.xset
      xorg.xdpyinfo

      home-manager
    ];
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      carlo = import ../../home/carlo/phoenix.nix;
    };
  };
}
