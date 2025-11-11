{
  description = "NixOS configuration for nix-asus";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, mango }: {
    nixosConfigurations.nix-asus = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixpkgs-stable nixpkgs-unstable home-manager mango;
      };
      modules = [
        ./hosts/nix-asus/configuration.nix
        home-manager.nixosModules.home-manager
        mango.nixosModules.mango
        {
          programs.mango.enable = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.mina = {
              # The home.stateVersion option does not have a default and must be set
              home.stateVersion = "25.05";
              imports = [
                mango.hmModules.mango
              ];
              wayland.windowManager.mango = {
                enable = true;
                settings = ''
                  # Mango configuration goes here
                  # See https://github.com/DreamMaoMao/mango/wiki/ for config options
                '';
                autostart_sh = ''
                  # Autostart commands go here
                  # Example: exec foot & (add programs to start automatically)
                '';
              };
            };
          };
        }
      ];
    };
  };
}