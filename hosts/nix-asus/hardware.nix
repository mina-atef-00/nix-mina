{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4cdb365c-f2a3-4088-88ae-44cf1d8542b6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8448-D59E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true; # Updated from deprecated driSupport32Bit
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production; # Changed from stable to production as requested
      forceFullCompositionPipeline = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };
    enableRedistributableFirmware = true;
  };

  # Bootloader - GRUB for desktop as requested
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
}
