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

        {
          name = "rust";
          indent = { tab-width = 2; unit = "  "; };
        }   
          
        {
          name = "html";
          formatter = { command = "prettier"; args = ["--parser" "html"]; };
        }     
        {
          name = "json";
          formatter = { command = "prettier"; args = ["--parser" "json"]; };
        }     
        {
          name = "css";
          formatter = { command = "prettier"; args = ["--parser" "css"]; };
        }     
        {
          name = "javascript";
          formatter = { command = "prettier"; args = ["--parser" "javascript"]; };
          auto-format = true;
          language-server = { command = "eslint"; args = ["--stdio"]; };
        }     
        {
          name = "typescript";
          formatter = { command = "prettier"; args = ["--parser" "typescript"]; };
          auto-format = true;
        }     
        {
          name = "tsx";
          formatter = { command = "prettier"; args = ["--parser" "tsx"]; };
          auto-format = true;
        }     
        {
          name = "jsx";
          formatter = { command = "prettier"; args = ["--parser" "jsx"]; };
          auto-format = true;
        }     
     ];
      grammar = [
        {
          name = "nix";
          source = {git = "https://github.com/nix-community/tree-sitter-nix"; rev = "1b69cf1fa92366eefbe6863c184e5d2ece5f187d";};
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
