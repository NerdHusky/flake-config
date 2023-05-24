{ config, pkgs, lib, inputs, ... }:
 
 {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        timeout = 3;
      };
      supportedFilesystems = [ "ntfs" ];
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
      bootspec.enable = true;
      kernelParams = [
        "quiet"
        "splash"
        "nvidia-drm.modeset=1"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
 }