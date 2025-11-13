{
  # Audio services
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # SSH server
    openssh = {
      enable = true;
      ports = [ 222 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        PermitEmptyPasswords = false;
      };
    };

    # Display manager (without Hyprland since it's being removed)
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.printing.enable = false;

  # Timezone
  time.timeZone = "Africa/Cairo";
}
