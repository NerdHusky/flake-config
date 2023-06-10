{pkgs, ...}:
{
	programs.tmux = {
		enable = true;

		clock24 = true;
		baseIndex = 1;
		shell = "${pkgs.fish}/bin/fish";
		
		extraConfig = ''
			source ${pkgs.powerline}/share/tmux/powerline.conf
			set -g default-terminal "tmux-256color"
		'';
	};
}
