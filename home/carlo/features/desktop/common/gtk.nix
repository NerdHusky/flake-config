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
    GTK_THEME = "Catppuccin-Mocha-Compact-Blue-Dark";
  };
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaLight;
    name = "Catppuccin-Mocha-Light-Cursors";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "blue" ];
        size = "compact";
        tweaks = [ "black" /* "normal" "rimless" */ ];
      };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Light-Cursors";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
      gtk-application-prefer-dark-theme = 1
    '';
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Catppuccin-Mocha-Compact-Blue-Dark";
      "Net/IconThemeName" = "Papirus-Dark";
      "Net/CursorThemeName" = "Catppuccin-Mocha-Light-Cursors";
      # "Gtk/CursorThemeName" = "Catppuccin-Mocha-Light-Cursors";
      # "Gtk-3.0/CursorThemeName" = "Catppuccin-Mocha-Light-Cursors";
    };
  };
}
