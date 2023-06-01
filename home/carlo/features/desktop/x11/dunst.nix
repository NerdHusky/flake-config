{
	services.dunst = {
		enable = true;

		settings = {
			global = {
				
		    monitor = 0;
		    follow = "mouse";
		    geometry = "300x60-15+46";
		    offset = "60x60";
		    indicate_hidden = "yes";
		    shrink = "yes";
		    transparency = 0;
		    notification_height = 0;
		    separator_height = 2;
		    padding = 8;
		    horizontal_padding = 12;
		    frame_width = 3;
		    frame_color = "#282738";
		    separator_color = "frame";
		    sort = "yes";
		    idle_threshold = 120;
		    font = "JetBrains Mono Bold 10";
		    line_height = 1;
		    markup = "full";
		    format = "<b>%s</b>\n%b";
		    alignment = "left";
		    show_age_threshold = 60;
		    word_wrap = "yes";
		    ellipsize = "middle";
		    ignore_newline = "no";
		    stack_duplicates = true;
		    hide_duplicate_count = false;
		    show_indicators = "yes";
		    icon_position = "left";
		    max_icon_size = 32;
		    # icon_path = /usr/share/icons/candy-icons/apps/scalable:/usr/share/icons/candy-icons/devices/scalable/;
		    sticky_history = "yes";
		    history_length = 20;
		    # dmenu = /usr/bin/dmenu -p dunst:;
		    # browser = /usr/bin/firefox -new-tab;
		    always_run_script = true;
		    title = "Dunst";
		    class = "Dunst";
		    startup_notification = false;
		    verbosity = "mesg";
		    corner_radius = 8;
		    force_xinerama = false;
		    mouse_left_click = "close_current";
		    mouse_middle_click = "do_action";
		    mouse_right_click = "close_all";
			};

			shortcuts = {
		    close = "ctrl+space";
		    close_all = "ctrl+shift+space";
		    history = "ctrl+grave";
		    context = "ctrl+shift+grave";
			};

			urgency_low = {
		    foreground = "#CAA9E0";
		    background = "#282738";
		    frame_color = "#282738";
		    timeout = 10;
		    # icon = ~/.config/dunst/images/notification.png;
			};

			urgency_normal = {
		    background = "#282738";
		    foreground = "#CAA9E0";
		    frame_color = "#282738";
		    timeout = 10;
		    # icon = ~/.config/dunst/images/notification.png;
			};

			urgency_critical = {
				
		    background = "#282738";
		    foreground = "#CAA9E0";
		    frame_color = "#282738";
		    timeout = 10;
		    # icon = ~/.config/dunst/images/notification.png;
			};

		};
	};
}
