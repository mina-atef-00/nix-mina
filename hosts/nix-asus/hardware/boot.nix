{
  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "vmd"
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };
    kernelModules = [
      "v4l2loopback"
      "uinput"
      "xpad"
      "kvm-intel"
    ];
    extraModulePackages = [ ];
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
      };
    };
  };
}
