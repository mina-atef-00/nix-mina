{
  description = "NixOS configuration for nix-asus";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, mango }: {
    nixosConfigurations.nix-asus = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixpkgs-stable nixpkgs-unstable mango;
      };
      modules = [
        ./hosts/nix-asus/configuration.nix
        mango.nixosModules.mango
        {
          programs.mango.enable = true;
        }
      ];
    };
  };
}