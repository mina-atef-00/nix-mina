{ config, ... }:

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

    # SSH server - using port 2200 as requested
    openssh = {
      enable = true;
      ports = [ 2200 ]; # DO NOT CHANGE THE PORT IN THE FUTURE
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        PermitEmptyPasswords = false;
      };
    };

    # Display manager - using greetd with tuigreet instead of Ly
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    printing.enable = false; # Set to false as requested
  };

  # Timezone
  time.timeZone = "Africa/Cairo";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
