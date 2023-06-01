{
	programs.rofi.enable = true;

	home.file."/home/carlo/.config/rofi/".recursive = true;
	home.file."/home/carlo/.config/rofi/".source = ./rofi;

	programs.rofi.configPath = "/home/carlo/.config/config.rasi";
}
