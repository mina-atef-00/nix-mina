{ config, pkgs, ... }:

{
  # X11 keyboard settings removed - handled by mango compositor
  # Keyboard layout handled by mango via xkb_rules_layout and xkb_rules_options

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
}