{imports, config, pkgs, ...}:
{

  imports = [
    ../common
		../x11
    # ../common/wayland-wm
    # inputs.hyprland.homeManagerModules.default
  ];
	# xsession.windowManager.awesome = {

		# enable = true;
		# package = pkgs.awesome;
		# luaModules = with pkgs; [
		# 	luajitPackages.luarocks
		# 	luajitPackages.luadbi-mysql
		# 	lua-language-server
		# 	luaPackages.gears
		# 	luaPackages.awful
		# 	luaPackages.wibox
		# 	luaPackages.beautiful
		# 	luaPackages.naughty
		# 	luaPackages.ruled
		# ];
			
		# noArgb = false;
	# };

	home.packages = with pkgs; [
		luajitPackages.luarocks-nix
		luajitPackages.luadbi-mysql
		lua-language-server
		luaformatter

		betterlockscreen
		feh
		xidlehook
		libsForQt5.qt5.qtgraphicaleffects
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtsvg
		conky
	];

	fonts.fontconfig.enable = true;

	home.file."/home/carlo/.config/awesome/".recursive = true;
	home.file."/home/carlo/.config/awesome/".source = ./awesome;
	home.file."/home/carlo/.config/conky/mocha.conf".source = ../x11/conky/mocha.conf;
	home.file."/home/carlo/.local/share/fonts/".recursive = true;
	home.file."/home/carlo/.local/share/fonts/".source = ../../../fonts;
}
