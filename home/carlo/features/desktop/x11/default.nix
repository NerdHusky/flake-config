{ pkgs, ... }:
{
  imports = [
    ./polybar.nix
  ];

  # home.packages = with pkgs; [
  #   grim
  #   imv
  #   mimeo
  #   # primary-xwayland
  #   xwayland
  #   pulseaudio
  #   slurp
  #   waypipe
  #   wf-recorder
  #   wl-clipboard
  #   wl-mirror
  #   # wl-mirror-pick
  #   ydotool
  # ];
}
