# { config, ... }:
# let
#   inherit (config) colorscheme;
# in
{
  # home.sessionVariables.COLORTERM = "truecolor";
  programs.helix = {
    enable = true;
    settings = {
      # theme = colorscheme.slug;
      theme = "catppuccin_mocha";
      editor = {
        color-modes = true;
        line-number = "relative";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys = {
        insert = {
          A-ret = "open_below";
        };
      };
    };
    languages ={
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = ["nix"];
          comment-token = "#";
          indent = { tab-width = 2; unit = "  "; };
          language-server = {command = "nil";} ;
          formatter = { command = "nixfmt";};
          # grammar = [{
          #   name = "nix";
          #   source = { git = "https://github.com/nix-community/tree-sitter-nix"; };
          # }];
        }
      ];
      grammar = [
        {
          name = "nix";
          source = {git = "https://github.com/nix-community/tree-sitter-nix";};
        }
      ];
    };
    # language = [
    #   {
    #     name = "lua";
    #     scope = "source.lua";
    #   }
    # ]
    # themes = import ./theme.nix { inherit colorscheme; };
  };
}
