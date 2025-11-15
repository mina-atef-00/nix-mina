{ config, ... }:

{
  services = {
    # Power management for laptop
    power-profiles-daemon.enable = true;

    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      lidSwitchDocked = "ignore";
    };

    acpid.enable = true;

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
      };
    };
  };
}
