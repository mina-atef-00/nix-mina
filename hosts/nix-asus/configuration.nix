{ config, pkgs, nixpkgs-stable, nixpkgs-unstable, ... }:

{
  imports = [
    # Import modular configuration files
    ./hardware/system-hardware.nix
    ./hardware/boot.nix
    ./hardware/networking.nix
    ./hardware/keyboard.nix
    ./modules/packages.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/system.nix
  ];

  # Use both stable and unstable packages
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (prev) system;
        config = { allowUnfree = true; };
      };
    })
  ];

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System state version
  system.stateVersion = "25.05";
}