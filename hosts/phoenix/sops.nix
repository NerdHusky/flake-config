{ config, inputs, pkgs, ... }:
{ 
  imports = [ 
		inputs.sops-nix.nixosModules.sops
  ];
      	
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ ];
  sops.age.keyFile = "/persist/sops.key";
  sops.secrets.carlo-password.neededForUsers = true;
  sops.gnupg.sshKeyPaths = [ ];

  environment.systemPackages = with pkgs; [
		sops
    age
    ssh-to-age
    pinentry-gnome3
    gcr
	];

  programs.gnupg.agent = {
    enable = true;
    # pinentryFlavor = "gnome3";
    # pinentryPackage = pkgs.pinentry_gnome;
  };
}

