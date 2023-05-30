{config, inputs, outputs, pkgs, ...}:

let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
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
      google-chrome
      aichat
      tdesktop
      element-desktop
      gimp
      inkscape
      libreoffice-fresh
      mpv
      vlc
      kitty
      imv
      vlc
      smplayer
      qbittorrent
      vscode
      # etcher
      # bootstrap-studio
      appimage-run
      glxinfo
      authy
      gnome.gnome-tweaks
      nix-prefetch
      nixpkgs.overlays.picom-pijulius
      # awesome

      airgeddon
      aircrack-ng
      coreutils-full
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
      dhcp
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

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      carlo = import ../../home/carlo/phoenix.nix;
    };
  };
}
