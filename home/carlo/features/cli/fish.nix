{ lib, config, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  # hasRipgrep = hasPackage "ripgrep";
  hasExa = hasPackage "exa";
  # hasNeovim = config.programs.neovim.enable;
  # hasEmacs = config.programs.emacs.enable;
  # hasNeomutt = config.programs.neomutt.enable;
  # hasKitty = config.programs.kitty.enable;
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = /* rec */ {
			sudo = "doas";
			
      # jqless = "jq -C | less -r";

      # n = "nix";
      # nd = "nix develop -c $SHELL";
      # ns = "nix shell";
      # nsn = "nix shell nixpkgs#";
      # nb = "nix build";
      # nbn = "nix build nixpkgs#";
      # nf = "nix flake";

      # nr = "nixos-rebuild --flake .";
      # nrs = "nixos-rebuild --flake . switch";
      # snr = "sudo nixos-rebuild --flake .";
      # snrs = "sudo nixos-rebuild --flake . switch";
      # hm = "home-manager --flake .";
      # hms = "home-manager --flake . switch";

      # ls = mkIf hasExa "exa -al --color=always --group-directories-first --icons";

			# l = mkIf hasExa "exa -ahl --color=always --group-directories-first --icons";

      # e = mkIf hasEmacs "emacsclient -t";

      # vrg = mkIf (hasNeomutt && hasRipgrep) "nvimrg";
      # vim = mkIf hasNeovim "nvim";
      # vi = vim;
      # v = vim;

      # mutt = mkIf hasNeomutt "neomutt";
      # m = mutt;

      # cik = mkIf hasKitty "clone-in-kitty --type os-window";
      # ck = cik;
			l = mkIf hasExa "exa -lhg";
			ll = mkIf hasExa "exa -lhng";
    };
    # shellAliases = {
    #   # Clear screen and scrollback
    #   clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    # };
    functions = {
			bind_bang = ''
				switch (commandline -t)[-1]
	        case "!"
	            commandline -t -- $history[1]
	            commandline -f repaint
	        case "*"
	            commandline -i !
  		end
			'';

		bind_dollar = ''
	    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
	    end
		'';

		fish_user_key_bindings = ''
	    bind ! bind_bang
	    bind '$' bind_dollar
		'';

		ls = ''
		  exa --color=always --group-directories-first --icons --across $argv
		'';

		# interactiveShellInit = ''
  #     set -g EDITOR hx
  #     set -g BROWSER brave
  #     set -g TERMINAL alacritty
  #   '';
				
  #     # Disable greeting
  #     fish_greeting = "";
  #     # Grep using ripgrep and pass to nvim
  #     nvimrg = mkIf (hasNeomutt && hasRipgrep) "nvim -q (rg --vimgrep $argv | psub)";
  #     # Integrate ssh with shellcolord
  #     ssh = mkIf hasShellColor ''
  #       ${shellcolor} disable $fish_pid
  #       # Check if kitty is available
  #       if set -q KITTY_PID && set -q KITTY_WINDOW_ID && type -q -f kitty
  #         kitty +kitten ssh $argv
  #       else
  #         command ssh $argv
  #       end
  #       ${shellcolor} enable $fish_pid
  #       ${shellcolor} apply $fish_pid
  #     '';
    };
		# interactiveShellInit = ''
		# 	set -l blue 89b4fa
		# 	set -l gray 6c7086
		# 	# Syntax Highlighting
		# 	set -g fish_color_normal $foreground
		# 	set -g fish_color_command $blue
		# 	set -g fish_color_param $flamingo
		# 	set -g fish_color_keyword $red
		# 	set -g fish_color_quote $green
		# 	set -g fish_color_redirection $pink
		# 	set -g fish_color_end $peach
		# 	set -g fish_color_error $red
		# 	set -g fish_color_gray $gray
		# 	set -g fish_color_selection --background=$selection
		# 	set -g fish_color_search_match --background=$selection
		# 	set -g fish_color_operator $pink
		# 	set -g fish_color_escape $flamingo
		# 	set -g fish_color_autosuggestion $gray
		# 	set -g fish_color_cancel $red
		# 	# Prompt
		# 	set -g fish_color_cwd $yellow
		# 	set -g fish_color_user $teal
		# 	set -g fish_color_host $blue
		# 	# Completion Pager
		# 	set -g fish_pager_color_progress $gray
		# 	set -g fish_pager_color_prefix $pink
		# 	set -g fish_pager_color_completion $foreground
		# 	set -g fish_pager_color_description $gray
		# '';
  #   interactiveShellInit =
  #     # Open command buffer in vim when alt+e is pressed
  #     ''
  #       bind \ee edit_command_buffer
  #     '' +
  #     # kitty integration
  #     ''
  #       set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
  #       set --global KITTY_SHELL_INTEGRATION enabled
  #       source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
  #       set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
  #     '' +
  #     # Use vim bindings and cursors
  #     ''
  #       fish_vi_key_bindings
  #       set fish_cursor_default     block      blink
  #       set fish_cursor_insert      line       blink
  #       set fish_cursor_replace_one underscore blink
  #       set fish_cursor_visual      block
  #     '' +
  #     # Use terminal colors
  #     ''
  #       set -U fish_color_autosuggestion      brblack
  #       set -U fish_color_cancel              -r
  #       set -U fish_color_command             brgreen
  #       set -U fish_color_comment             brmagenta
  #       set -U fish_color_cwd                 green
  #       set -U fish_color_cwd_root            red
  #       set -U fish_color_end                 brmagenta
  #       set -U fish_color_error               brred
  #       set -U fish_color_escape              brcyan
  #       set -U fish_color_history_current     --bold
  #       set -U fish_color_host                normal
  #       set -U fish_color_match               --background=brblue
  #       set -U fish_color_normal              normal
  #       set -U fish_color_operator            cyan
  #       set -U fish_color_param               brblue
  #       set -U fish_color_quote               yellow
  #       set -U fish_color_redirection         bryellow
  #       set -U fish_color_search_match        'bryellow' '--background=brblack'
  #       set -U fish_color_selection           'white' '--bold' '--background=brblack'
  #       set -U fish_color_status              red
  #       set -U fish_color_user                brgreen
  #       set -U fish_color_valid_path          --underline
  #       set -U fish_pager_color_completion    normal
  #       set -U fish_pager_color_description   yellow
  #       set -U fish_pager_color_prefix        'white' '--bold' '--underline'
  #       set -U fish_pager_color_progress      'brwhite' '--background=cyan'
  #     '';
  };
}
