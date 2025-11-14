{
  nixpkgs-unstable,
  ...
}:

{
  # Use both stable and unstable packages
  nixpkgs.overlays = [
    (_final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (prev) system;
        config = {
          allowUnfree = true;
        };
      };
    })
  ];

  # Enable experimental features (already in shared but adding here as well for clarity)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System state version (already in shared but adding here as well for clarity)
  system.stateVersion = "25.05";
}
