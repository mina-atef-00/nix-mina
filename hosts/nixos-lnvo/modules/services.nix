{ config, ... }:

{
  services = {
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
