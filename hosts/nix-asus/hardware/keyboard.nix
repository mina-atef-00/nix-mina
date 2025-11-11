{ config, pkgs, ... }:

{
  services.xserver = {
    xkb.options = "grp:win_space_toggle";
    xkb.layout = "us,ara";
  };

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
}