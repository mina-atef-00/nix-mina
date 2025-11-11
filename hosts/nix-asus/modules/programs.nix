{ config, pkgs, ... }:

{
  # Programs configuration
 programs = {
    # Git configuration
    git = {
      enable = true;
      config = {
        user = {
          name = "mina";
          email = "mina@example.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };

    # Mango compositor configuration
    # Note: Mango is enabled in the flake.nix file as a NixOS module
    # Configuration for Mango can be set here if needed

    # Enable and configure other programs as needed
    # Add more program configurations here as needed
  };

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      # Basic MangoWC configuration
      gappih = 5
      gappiv = 5
      gappoh = 10
      gappov = 10
      borderpx = 2
      bordercolor = 0x444ff
      focuscolor = 0x07aff
      
      # Focus and behavior settings
      sloppyfocus = 1
      focus_on_activate = 1
      
      # Key bindings with full paths for reliability
      bind=SUPER,Return,spawn,kitty
      bind=SUPER,w,spawn,firefox
      bind=SUPER,q,killclient
      bind=SUPER+r,reload_config
      bind=SUPER+SHIFT,e,quit
      bind=SUPER+SHIFT,q,quit
    '';
    autostart_sh = ''
      # Add any startup applications here
      sleep 2  # Allow time for WM to initialize
    '';
  };


  # Additional program-related configurations that don't fit under programs.*
}