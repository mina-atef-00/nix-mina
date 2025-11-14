{
  description = "NixOS configuration for both nix-asus and nixos-lnvo";

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

  outputs =
    {
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      mango,
      ...
    }:
    {
      nixosConfigurations.nix-asus = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit
            nixpkgs-stable
            nixpkgs-unstable
            home-manager
            mango
            ;
        };
        modules = [
          # Import shared modules
          ./shared/modules/packages.nix
          ./shared/modules/programs.nix
          ./shared/modules/services.nix
          ./shared/modules/system.nix
          ./shared/modules/users.nix

          # Import desktop-specific hardware
          ./hosts/nix-asus/hardware.nix

          # Import desktop-specific modules
          ./hosts/nix-asus/modules/packages.nix
          ./hosts/nix-asus/modules/services.nix

          # Import user modules via home-manager
          home-manager.nixosModules.home-manager
          mango.nixosModules.mango
          {
            programs.mango.enable = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.mina = {
                # Import shared home configurations
                imports = [
                  ./shared/home/mina/mango.nix
                  ./shared/home/mina/fish.nix
                  ./shared/home/mina/kitty.nix
                  ./shared/home/mina/starship.nix
                  ./shared/home/mina/direnv.nix
                  ./shared/home/mina/neovim.nix
                  mango.hmModules.mango
                ];

                # The home.stateVersion option does not have a default and must be set
                home = {
                  stateVersion = "25.05";
                  enableNixpkgsReleaseCheck = false; # Disable version check due to HM/Nixpkgs version mismatch
                };

                # XDG configuration
                xdg = {
                  enable = true;
                  # Mime types
                  mimeApps = {
                    enable = true;
                    defaultApplications = {
                      "text/html" = "zen-browser.desktop";
                      "x-scheme-handler/http" = "zen-browser.desktop";
                      "x-scheme-handler/https" = "zen-browser.desktop";
                      "x-scheme-handler/about" = "zen-browser.desktop";
                      "x-scheme-handler/ftp" = "zen-browser.desktop";
                      "x-scheme-handler/chrome" = "zen-browser.desktop";
                      "application/x-extension-htm" = "zen-browser.desktop";
                      "application/x-extension-html" = "zen-browser.desktop";
                      "application/x-extension-shtml" = "zen-browser.desktop";
                      "application/xhtml+xml" = "zen-browser.desktop";
                      "application/x-extension-xhtml" = "zen-browser.desktop";
                      "application/x-extension-xht" = "zen-browser.desktop";
                      "audio/*" = "mpv.desktop";
                      "video/*" = "mpv.desktop";
                    };
                  };
                  # Desktop portal for Wayland
                  desktopEntries = {
                    zen-browser = {
                      name = "Zen Browser";
                      exec = "zen %U";
                      type = "Application";
                      mimeType = [
                        "text/html"
                        "x-scheme-handler/http"
                        "x-scheme-handler/https"
                      ];
                    };
                  };
                };
                # Environment variables
                home.sessionVariables = {
                  EDITOR = "nvim"; # System-installed
                  BROWSER = "zen"; # Set in system packages instead
                  TERMINAL = "kitty"; # System-installed
                  READER = "zathura"; # System-installed
                  XDG_CURRENT_DESKTOP = "mangowc"; # Keep this for compatibility when mangowc is re-enabled
                  XDG_SESSION_TYPE = "wayland";
                  MOZ_ENABLE_WAYLAND = "1";
                  QT_QPA_PLATFORM = "wayland";
                  QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                  CLUTTER_BACKEND = "wayland";
                  SDL_VIDEODRIVER = "wayland";
                  _JAVA_AWT_WM_NONREPARENTING = "1";
                  NIXOS_OZONE_WL = "1";
                  # Additional environment variables for NVIDIA/Wayland compatibility
                  WLR_NO_HARDWARE_CURSORS = "1";
                  WLR_RENDERER_ALLOW_SOFTWARE = "1";
                };
              };
            };
          }
        ];
      };

      nixosConfigurations.nixos-lnvo = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit
            nixpkgs-stable
            nixpkgs-unstable
            home-manager
            mango
            ;
        };
        modules = [
          # Import shared modules
          ./shared/modules/packages.nix
          ./shared/modules/programs.nix
          ./shared/modules/services.nix # This excludes printing and GNOME
          ./shared/modules/system.nix
          ./shared/modules/users.nix

          # Import laptop-specific hardware
          ./hosts/nixos-lnvo/hardware.nix

          # Import laptop-specific modules
          ./hosts/nixos-lnvo/modules/services.nix
          ./hosts/nixos-lnvo/modules/packages.nix

          # Import user modules via home-manager
          home-manager.nixosModules.home-manager
          mango.nixosModules.mango
          {
            programs.mango.enable = true;
            networking.hostName = "nixos-lnvo"; # Set laptop hostname
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.mina = {
                # Import shared home configurations
                imports = [
                  ./shared/home/mina/mango.nix
                  ./shared/home/mina/fish.nix
                  ./shared/home/mina/kitty.nix
                  ./shared/home/mina/starship.nix
                  ./shared/home/mina/direnv.nix
                  ./shared/home/mina/neovim.nix
                  mango.hmModules.mango
                ];

                # The home.stateVersion option does not have a default and must be set
                home = {
                  stateVersion = "25.05";
                  enableNixpkgsReleaseCheck = false; # Disable version check due to HM/Nixpkgs version mismatch
                };

                # XDG configuration
                xdg = {
                  enable = true;
                  # Mime types
                  mimeApps = {
                    enable = true;
                    defaultApplications = {
                      "text/html" = "zen-browser.desktop";
                      "x-scheme-handler/http" = "zen-browser.desktop";
                      "x-scheme-handler/https" = "zen-browser.desktop";
                      "x-scheme-handler/about" = "zen-browser.desktop";
                      "x-scheme-handler/ftp" = "zen-browser.desktop";
                      "x-scheme-handler/chrome" = "zen-browser.desktop";
                      "application/x-extension-htm" = "zen-browser.desktop";
                      "application/x-extension-html" = "zen-browser.desktop";
                      "application/x-extension-shtml" = "zen-browser.desktop";
                      "application/xhtml+xml" = "zen-browser.desktop";
                      "application/x-extension-xhtml" = "zen-browser.desktop";
                      "application/x-extension-xht" = "zen-browser.desktop";
                      "audio/*" = "mpv.desktop";
                      "video/*" = "mpv.desktop";
                    };
                  };
                  # Desktop portal for Wayland
                  desktopEntries = {
                    zen-browser = {
                      name = "Zen Browser";
                      exec = "zen %U";
                      type = "Application";
                      mimeType = [
                        "text/html"
                        "x-scheme-handler/http"
                        "x-scheme-handler/https"
                      ];
                    };
                  };
                };
                # Environment variables
                home.sessionVariables = {
                  EDITOR = "nvim"; # System-installed
                  BROWSER = "zen"; # Set in system packages instead
                  TERMINAL = "kitty"; # System-installed
                  READER = "zathura"; # System-installed
                  XDG_CURRENT_DESKTOP = "mangowc"; # Keep this for compatibility when mangowc is re-enabled
                  XDG_SESSION_TYPE = "wayland";
                  MOZ_ENABLE_WAYLAND = "1";
                  QT_QPA_PLATFORM = "wayland";
                  QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                  CLUTTER_BACKEND = "wayland";
                  SDL_VIDEODRIVER = "wayland";
                  _JAVA_AWT_WM_NONREPARENTING = "1";
                  NIXOS_OZONE_WL = "1";
                };
              };
            };
          }
        ];
      };
    };
}
