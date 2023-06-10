{ config, pkgs, ... }:
{
	virtualisation = {
		docker = {
			
			enable = true;
			enableNvidia = true;
		};
    
		lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
		
		libvirtd = {
      enable = true;
      # onBoot = "ignore";
    };
	};

	users.groups.docker.members = [ "carlo" ];
  users.groups.libvirtd.members = [ "carlo" ];
	users.users.carlo = {
    extraGroups = [ "lxd" ];
  };

  environment.systemPackages = with pkgs; [
    docker-compose
		# nvidia-docker
		virt-manager
		qemu
  ];

	networking.firewall.trustedInterfaces = [ "virbr0" ];
  programs.dconf.enable = true;
}