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

    

    # Enable and configure other programs as needed
    # Add more program configurations here as needed
  };


  # Additional program-related configurations that don't fit under programs.*
}