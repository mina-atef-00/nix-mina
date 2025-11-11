{ config, pkgs, ... }:

{
  # Audio services
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # SSH server
 services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      PermitEmptyPasswords = false;
    };
  };

  # Display manager (without Hyprland since it's being removed)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Timezone
  time.timeZone = "UTC";
}