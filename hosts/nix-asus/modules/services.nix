{ config, ... }:

{
  services = {
    # Display manager for desktop (with MangoWM)
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
