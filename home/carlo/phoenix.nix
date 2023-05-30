{ inputs, outputs, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    # ./features/desktop/awesome
    # ./features/rgb
    # ./features/productivity
    # ./features/pass
    # ./features/games
    # ./features/music
  ];

  # wallpaper = outputs.wallpapers.temple-fantasy-blue;
  # wallpaper = ${./wallpaper.png};
  # colorscheme = inputs.nix-colors.colorSchemes.tokyo-city-terminal-dark;
  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # #  ------   -----   ------
  # # | DP-3 | | DP-1| | DP-2 |
  # #  ------   -----   ------
  # monitors = [
  #   {
  #     name = "DP-3";
  #     width = 1920;
  #     height = 1080;
  #     noBar = true;
  #     x = 0;
  #     workspace = "3";
  #     enabled = false;
  #   }
  #   {
  #     name = "DP-1";
  #     width = 2560;
  #     height = 1080;
  #     refreshRate = 75;
  #     x = 1920;
  #     workspace = "1";
  #   }
  #   {
  #     name = "DP-2";
  #     width = 1920;
  #     height = 1080;
  #     noBar = true;
  #     x = 4480;
  #     workspace = "2";
  #   }
  # ];
}
