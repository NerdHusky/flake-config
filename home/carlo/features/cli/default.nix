{ pkgs, ... }: 
{
  imports = [
    # ./bash.nix
    # ./bat.nix
    # ./direnv.nix
    ./fish.nix
    ./nushell.nix
    # ./gh.nix
    # ./git.nix
    # ./gpg.nix
    # ./nix-index.nix
    # ./pfetch.nix
    # ./ranger.nix
    # ./screen.nix
    # ./shellcolor.nix
    # ./ssh.nix
    ./starship.nix
    ./tmux.nix
    # ./demacs.nix
    # ./xpo.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    distrobox # Nice escape hatch, integrates docker images with my environment

    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    exa # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator

    nil # Nix LSP
    nixfmt # Nix formatter

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    neofetch
    pipes
    matrixcli
    killall
    # git
    btop
    htop
    hdparm
    aria
    ranger
    nix-index
    pciutils
    zip
    unzip
    pass
    polkit
    p7zip
    speedtest-cli
    
    fzf
    # tldr
    tealdeer
    cht-sh

    ### Programming, will find another place
    nodejs_18
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.typescript-language-server
    # nodePackages.prisma
    node2nix
    deno
    # bun
    yarn
    elixir
    go
    gopls
    gccgo
    # gcc_multi
    python311
    rustup
    mongodb-compass

    # ltex-ls # Spell checking LSP
  ];
}
