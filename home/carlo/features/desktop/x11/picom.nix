{pkgs, ...}:
{
	services.picom = {
		enable = true;
		# package = pkgs.picom-pijulius;
		package = pkgs.picom-jonaburg;

		settings = {
			#################################
			#          Animations           #
			#################################
			transition-length = 300;
			transition-pow-x = 0.1;
			transition-pow-y = 0.1;
			transition-pow-w = 0.1;
			transition-pow-h = 0.1;
			size-transition = true;


			#################################
			#             Corners           #
			#################################
			corner-radius = 10.0;
			rounded-corners-exclude = [
			  "class_g = 'awesome'"
			  "class_g = 'URxvt'"
			  "class_g = 'XTerm'"
			  "class_g = 'Polybar'"
			  "class_g = 'code-oss'"
			  "class_g = 'Thunderbird'"
			];
			round-borders = 1;
			round-borders-exclude = [
			];

			#################################
			#             Shadows           #
			#################################
			shadow = true;
			shadow-radius = 15;

			shadow-offset-x = -15;

			shadow-exclude = [
			    "window_type = 'popup_menu'"
			    "window_type = 'dropdown_menu'"
			    "window_type = 'menu'"
			    "window_type = 'tooltip'"
			];


			#################################
			#           Fading              #
			#################################
			fading = false;
			fade-in-step = 0.03;
			fade-out-step = 0.03;
			fade-exclude = [
			  "class_g = 'slop'"   # maim
			];

			#################################
			#   Transparency / Opacity      #
			#################################
			inactive-opacity = 0.8;
			frame-opacity = 0.7;
			popup_menu = { opacity = 0.8; };
			dropdown_menu = { opacity = 0.8; };
			inactive-opacity-override = false;

			active-opacity = 1.0;
			focus-exclude = [
			  "class_g = 'Cairo-clock'"
			  "class_g = 'Bar'"                    # lemonbar
			  "class_g = 'slop'"                    # maim
			];

			opacity-rule = [
			  "80:class_g     = 'Bar'"             # lemonbar
			  "100:class_g    = 'slop'"            # maim
			  "100:class_g    = 'XTerm'"
			  "100:class_g    = 'URxvt'"
			  "70:class_g    = 'st'"
			  "100:class_g    = 'Alacritty'"
			  "80:class_g     = 'Polybar'"
			  "100:class_g    = 'code-oss'"
			  "100:class_g    = 'Meld'"
			  "100:class_g     = 'TelegramDesktop'"
			  "90:class_g     = 'Joplin'"
			  "100:class_g    = 'firefox'"
			  "100:class_g    = 'Thunderbird'"
			];


			#################################
			#     Background-Blurring       #
			#################################
			blur = {
			  method = "kawase";
			  strength = 49;
			  background = false;
			  background-frame = false;
			  background-fixed = false;
			  kern = "3x3box";
			};

			blur-background-exclude = [
			  "class_g = 'slop'"
			  "_GTK_FRAME_EXTENTS@:c"
			];


			#################################
			#       General Settings        #
			#################################

			backend = "glx";
			vsync = false;
			mark-wmwin-focused = true;
			mark-ovredir-focused = true;
			detect-rounded-corners = true;
			detect-client-opacity = true;
			refresh-rate = 60;
			detect-transient = true;
			detect-client-leader = true;
			log-level = "info";
	  };
	};
}
