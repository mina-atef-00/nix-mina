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
    device = "/dev/disk/by-uuid/325bc920-adae-4068-8009-765f0ca34ac7";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A18E-76C7";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ]; # Will use ZRAM instead

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;

    # Intel GPU configuration (no NVIDIA)
    graphics = {
      enable = true;
      enable32Bit = true; # Updated from deprecated driSupport32Bit
    };

    enableRedistributableFirmware = true;
  };

  # ZRAM swap - fixed to use single attribute set as requested by statix
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # 50% of available RAM as compressed swap
  };
}
