{ config, pkgs, inputs, ... }:

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

    # Enable and configure other programs as needed
    # Add more program configurations here as needed
    fish.enable = true;
  };

# Additional program-related configurations that don't fit under programs.*
  
  # Install packages that might help with Wayland/Mango compatibility
  environment.systemPackages = with pkgs; [
    # Wayland utilities
    wayland-utils
    wlr-randr
    swaybg
    swaylock
    swayidle
    
    # Graphics and rendering
    mesa
    vulkan-tools
    glxinfo
    
    # Additional Wayland protocols support
    xdg-utils
  ];
}