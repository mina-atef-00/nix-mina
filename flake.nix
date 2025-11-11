{
  description = "NixOS configuration for nix-asus";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable }: {
    nixosConfigurations.nix-asus = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixpkgs-stable nixpkgs-unstable;
      };
      modules = [
        ./hosts/nix-asus/configuration.nix
      ];
    };
  };
}