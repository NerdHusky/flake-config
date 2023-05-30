{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    # home-manager.url = "github:nix-community/home-manager/release-22.11";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
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

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... }@inputs:
    let
      inherit (self) outputs;
      # forAllSystems = nixpkgs.lib.genAttrs [
      #   "aarch64-linux"
      #   "i686-linux"
      #   "x86_64-linux"
      #   "aarch64-darwin"
      #   "x86_64-darwin"
      # ];
      # systems = [ "x86_64-linux" ];
      # pkgs = import nixpkgs { /*inherit system;*/ overlays = [
      
      # {
      #     final: prev: { prev.awesome.overrideAttrs (old: {
      #       src = prev.fetchFromGitHub {
      #         owner = "awesomeWM";
      #         repo = "awesome";
      #         rev = "485661b706752212dac35e91bb24a0e16a677b70";
      #         sha256 = "0000000000000000000000000000000000000000000";
      #       };
      #     })}
      # }

      # {
      #     final: prev: { prev.picom.overrideAttrs (old: {
      #     src = prev.fetchFromGitHub {
      #       owner = "pijulius";
      #       repo = "picom";
      #       rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
      #       sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
      #     };
      #   })}
      # }
      # ]; };
      
    in
    {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      # packages = forAllSystems (system:
      #   let pkgs = nixpkgs.legacyPackages.${system};
      #   in import ./pkgs { inherit pkgs; }
      # );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      # devShells = forAllSystems (system:
      #   let pkgs = nixpkgs.legacyPackages.${system};
      #   in import ./shell.nix { inherit pkgs; }
      # );

      # Your custom packages and modifications, exported as overlays
      # nixpkgs.overlays = import ./overlays { inherit inputs; };
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      # nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      # homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        phoenix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # nixpkgs-f2k.nixosModules.stevenblack # stevenblack hosts adblocking, refer to ./modules/stevenblack.nix for options

            # nixpkgs.overlays # = import ./overlays { inherit inputs; };
          	# # using the overlays (most likely you want)
          	# {
          	#   nixpkgs.overlays = [
          	#     # Check flake.nix or clone and use `nix flake show` for available subsets of overlays

          	#     nixpkgs-f2k.overlays.compositors # for X11 compositors
          	#     nixpkgs-f2k.overlays.window-managers # window managers such as awesome or river
          	#     nixpkgs-f2k.overlays.stdenvs # stdenvs with compiler optimizations, and library functions for optimizing them
          	#     # nixpkgs-f2k.overlays.default # for all packages
          	#   ];
          	# }
            # > Our main nixos configuration file <
            ./hosts/phoenix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "carlo@phoenix" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # nixpkgs-f2k.nixosModules.stevenblack # stevenblack hosts adblocking, refer to ./modules/stevenblack.nix for options

          	# # using the overlays (most likely you want)
          	# {
          	#   nixpkgs.overlays = [
          	#     # Check flake.nix or clone and use `nix flake show` for available subsets of overlays

          	#     nixpkgs-f2k.overlays.compositors # for X11 compositors
          	#     nixpkgs-f2k.overlays.window-managers # window managers such as awesome or river
          	#     nixpkgs-f2k.overlays.stdenvs # stdenvs with compiler optimizations, and library functions for optimizing them
          	#     # nixpkgs-f2k.overlays.default # for all packages
          	#   ];
          	# }
            # > Our main home-manager configuration file <
            ./home/carlo/phoenix.nix
          ];
          # pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          pkgs = [
            nixpkgs.legacyPackages.x86_64-linux # Home-manager requires 'pkgs' instance
            nixpkgs-f2k
          ];
        };
      };
    };
}