{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
  # inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) colorschemeFromPicture nixWallpaperFromScheme;
in
{
  imports = [
    # inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModule
    # ../features/cli
    # ../features/nvim
    (./features/helix)
  ];
  # ] ++ (builtins.attrValues outputs.homeManagerModules);

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs outputs; };
  # };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "carlo";
    homeDirectory = lib.mkDefault "/home/carlo";
    stateVersion = lib.mkDefault "22.11";
    sessionPath = [ "$HOME/.local/bin" ];

  #   persistence = {
  #     "/persist/home/misterio" = {
  #       directories = [
  #         "Documents"
  #         "Downloads"
  #         "Pictures"
  #         "Videos"
  #         ".local/bin"
  #       ];
  #       allowOther = true;
  #     };
  #   };
  };

  colorscheme = lib.mkDefault colorSchemes.catppuccin-mocha;
  # colorscheme = lib.mkDefault colorSchemes.nord;
  # wallpaper =
  #   let
  #     largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
  #     largestWidth = largest (x: x.width) config.monitors;
  #     largestHeight = largest (x: x.height) config.monitors;
  #   in
  #   lib.mkDefault (nixWallpaperFromScheme
  #     {
  #       scheme = config.colorscheme;
  #       width = largestWidth;
  #       height = largestHeight;
  #       logoScale = 4;
  #     });
  home.file.".colorscheme".text = config.colorscheme.slug;
}
