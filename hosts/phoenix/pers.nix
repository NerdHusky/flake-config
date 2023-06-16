{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [ 
      inputs.impermanence.nixosModules.impermanence
    ];

  environment.persistence = {
    "/persist" = {
      directories = [
        "/etc/nixos"
        # "/etc/ssh"
        "/etc/NetworkManager/system-connections"
        "/var/lib/systemd"
        "/var/lib/nixos"
        "/var/lib/docker"
        "/var/lib/lxd"
        "/var/lib/libvirt"
        "/var/lib/cups"
        "/var/cache/cups"
      ];
      
      files = [
        "/etc/machine-id"
        "/etc/adjtime"
      ];
    };
  };
}
