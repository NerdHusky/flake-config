{
	programs.alacritty = {
		enable = true;

		settings = {
			window = {
				opacity = 0.70;
				
				dimensions = {
					columns = 82;
					lines = 24;
				};
				
			  padding = {
			    x = 30;
			    y = 30;
				};
		    # dynamic_padding = true;
			};
 

			scrolling = {
			  history = 10000;
			  multiplier = 3;
			};

			cursor = {
				sytle = {
					shape = "Block";
					blinking = "on";
				};
				unfocused_hollow = false;
			};

			colors = {
				background = "#282738";
				live_config_reload = true;
			};

			font = {
			  # Normal (roman) font face
			  normal = {
			    family = "JetBrainsMono Nerd Font";
				};

				# Bold font face
			  bold = {
			    family = "JetBrainsMono Nerd Font";
				};

			  # Italic font face
			  italic = {
			    family = "JetBrainsMono Nerd Font";
				};

			  # Bold italic font face
			  bold_italic = {
			    family = "JetBrainsMono Nerd Font";
				};
			  size = 9;
			};

			colors = {
			  # Default colors
			  primary = {
			    background = "#1E2128";
			    foreground = "#ABB2BF";
				};

			  # Normal colors
			  normal = {
			    black =   "#32363D";
			    red =     "#E06B74";
			    green =   "#98C379";
			    yellow =  "#E5C07A";
			    blue =    "#62AEEF";
			    magenta = "#C778DD";
			    cyan =    "#55B6C2";
			    white =   "#ABB2BF";
				};

			  # Bright colors
			  bright = {
			    black =   "#50545B";
			    red =     "#EA757E";
			    green =   "#A2CD83";
			    yellow =  "#EFCA84";
			    blue =    "#6CB8F9";
			    magenta = "#D282E7";
			    cyan =    "#5FC0CC";
			    white =   "#B5BCC9";
				};
			};
	};
}
