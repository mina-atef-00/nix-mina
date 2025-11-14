{ config, ... }:

{
  # All packages are now in shared/modules/packages.nix
  # This file remains for potential future host-specific packages
  environment.systemPackages = [ ];
}
