{config, inputs, outputs, pkgs, ...}:

let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
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
      authy

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
