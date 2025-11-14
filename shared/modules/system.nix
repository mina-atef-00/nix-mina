{ config, ... }:

{
  # System state version
  system.stateVersion = "25.05";

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
