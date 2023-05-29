{
	programs.alacritty = {
		enable = true;

		settings = {
			window = {
				opacity = 0.70;
			  padding = {
			    x = 5;
			    y = 0;
				};
		    dynamic_padding = true;
			};
 

			scrolling = {
			  # Maximum number of lines in the scrollback buffer.
			  # Specifying '0' will disable scrolling.
			  history = 10000;

			  # Scrolling distance multiplier.
			  multiplier = 3;
			};

			# Font configuration
			font = {
			  # Normal (roman) font face
			  normal = {
			    family = "RobotoMono Nerd Font";

			    style = "Regular";
				};

			  # Bold font face
			  bold = {
			    family = "RobotoMono Nerd Font";

			    style = "Bold";
				};

			  # Italic font face
			  italic = {
			    family = "RobotoMono Nerd Font";

			    style = "Italic";
				};

			  # Bold italic font face
			  bold_italic = {
			    family = "RobotoMono Nerd Font";

			    style = "Bold Italic";
				};

				size = 10;
			};
		

			colors = {
			  primary = {
			    background = "#1e1e2e";
			    foreground = "#b4befe";
				};

			  # Normal colors
			  normal = {
			    black =   "#24273a";
			    red =     "#ed8796";
			    green =   "#a6da95";
			    yellow =  "#eed49f";
			    blue =    "#8aadf4";
			    magenta = "#c6a0f6";
			    cyan =    "#8bd5ca";
			    white =   "#cad3f5";
				};

			  # Bright colors
			  bright = {
			    black =   "#303446";
			    red =     "#e78284";
			    green =   "#a6d189";
			    yellow =  "#e5c890";
			    blue =   "#8caaee";
			    magenta = "#ca9ee6";
			    cyan =    "#81c8be";
			    white =   "#c6d0f5";
				};
			};
 
		  # Cursor style
		  style = {
		    shape = "Block";
		    blinking = "Off";
			};

			key_bindings = [
				{ key = "Back"; mods = "Control"; chars = "\u0017"; }
			];
		};
	};
}
