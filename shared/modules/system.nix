{ config, ... }:

{
  # System state version
  system.stateVersion = "25.05";

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader - Using GRUB for all systems
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };

  # Explicitly disable systemd-boot to prevent conflicts
  boot.loader.systemd-boot.enable = false;
}
