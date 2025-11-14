{ config, ... }:

{
  programs = {
    # Enable and configure fish shell
    fish = {
      enable = true;
    };

    # Enable Firefox browser
    firefox.enable = true;
  };

  # Enable NetworkManager for networking
  networking.networkmanager.enable = true;
}
