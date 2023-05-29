{ pkgs, ... }:
{
  imports = [
    # ./hyprland-vnc.nix
    ./gammastep.nix
    ./kitty.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
    ./zathura.nix
    ./wezterm.nix
  ];

  home.packages = with pkgs; [
    grim
    imv
    mimeo
    # primary-xwayland
    xwayland
    pulseaudio
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    # wl-mirror-pick
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
	  LIBVA_DRIVER_NAME = "nvidia";
		XDG_SESSION_TYPE = "wayland";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = "1";
    # GDK_BACKEND = "x11";
  };
}
