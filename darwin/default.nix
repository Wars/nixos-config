#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       └─ <host>.nix
#

{ inputs, nixpkgs-unstable, darwin, home-manager-unstable, nixvim-unstable, vars, ... }:

let
  system = "aarch64-darwin";                                 # System architecture
  pkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  # MacBook
  mcat = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs vars; };
    modules = [
      nixvim-unstable.nixDarwinModules.nixvim
      ./mcat.nix
      ../modules/editors/nvim.nix
      ../modules/programs/kitty.nix

      home-manager-unstable.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
