{
  description = "Carlo Cuoghi (NerdHusky86) Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/NUR";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nix-colors, nixpkgs-f2k, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

      mkNixos = modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    in
    {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      # packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }) // {
        # neovim = let
        #   homeCfg = mkHome [ ./home/misterio/generic.nix ] pkgs;
        # in pkgs.writeShellScriptBin "nvim" ''
        #   ${homeCfg.config.programs.neovim.finalPackage}/bin/nvim \
        #   -u ${homeCfg.config.xdg.configFile."nvim/init.lua".source} \
        #   "$@"
        # '';
      # });
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      # devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachPkgs (pkgs: pkgs.nixpkgs-fmt);
      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays /* { inherit outputs; }*/;
      # overlays =
      # # Apply each overlay found in the /overlays directory
      # let path = ./overlays; in with builtins;
      # map (n: import (path + ("/" + n)))
      #     (filter (n: match ".*\\.nix" n != null ||
      #                 pathExists (path + ("/" + n + "/default.nix")))
      #             (attrNames (readDir path)));
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # Desktops
        phoenix = mkNixos [ ./hosts/phoenix ];
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # Desktops
        "carlo@phoenix" = mkHome [ ./home/carlo/phoenix.nix ] nixpkgs.legacyPackages."x86_64-linux";
      };

    };
}
