{imports, config, pkgs, ...}:
{
  imports = [
    ../common
		../x11
  ];
	
	# services.xserver.windowManager.qtile = {
	# 	enable = true;
	# 	package = pkgs.qtile;
	# 	configFile = /home/carlo/.config/qtile/config.py;
	# }; 

	home.file."/home/carlo/.config/qtile/".recursive = true;
	home.file."/home/carlo/.config/qtile/".source = ./qtile;
		
	home.packages = with pkgs; [
		pywal
		feh
	];
}