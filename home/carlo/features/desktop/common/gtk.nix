{ config, pkgs, inputs, ... }:

# let
#   inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
# in
# rec {
#   gtk = {
#     enable = true;
#     font = {
#       # name = config.fontProfiles.regular.family;
#       name = "Fira Sans";
#       size = 12;
#     };
#     theme = {
#       name = "${config.colorscheme.slug}";
#       package = gtkThemeFromScheme { scheme = config.colorscheme; };
#     };
#     iconTheme = {
#       name = "Papirus";
#       package = pkgs.papirus-icon-theme;
#     };
#   };

#   services.xsettingsd = {
#     enable = true;
#     settings = {
#       "Net/ThemeName" = "${gtk.theme.name}";
#       "Net/IconThemeName" = "${gtk.iconTheme.name}";
#     };
#   };
# }

{
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Blue";
  };
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors;
    name = "Catppuccin-Mocha-Dark";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha_Blue";
      package = pkgs.catppuccin-gtk;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Catppuccin-Mocha-Blue";
      "Net/IconThemeName" = "Papirus-Dark";
    };
  };
}
