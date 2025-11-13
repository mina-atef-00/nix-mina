{
  networking = {
    hostName = "nix-asus";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 2222 ]; # SSH on new port
      allowedUDPPorts = [ ]; # No specific UDP ports
      allowPing = false; # Disable ping unless needed for diagnostics
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
