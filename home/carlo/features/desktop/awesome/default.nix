{imports, config, pkgs, ...}:
{

  imports = [
    ../common
		../x11
    # ../common/wayland-wm
    # inputs.hyprland.homeManagerModules.default
  ];
	xsession.windowManager.awesome = {

		enable = true;
		package = pkgs.awesome;
		luaModules = with pkgs; [
			luajitPackages.luarocks
			luajitPackages.luadbi-mysql
			lua-language-server
		];
			
		noArgb = false;
	};

	home.packages = with pkgs; [
		betterlockscreen
	];
}
