{imports, config, pkgs, ...}:
{
	xsession.windowManger.awesome = {
		enable = true;
		package = pkgs.awesome;
		luaModules = with pkgs; [
			luajitPackages.luarocks
			luajitPackages.luadbi-mysql
			lua-language-server
		];
		noArgb = false;
	};
}
