{ pkgs, ... }:

{
  users.users = {
    "mina" = {
      isNormalUser = true;
      group = "mina"; # Required to avoid the error
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
        "podman"
      ];
      hashedPassword = "$6$rounds=4096$0nh2sl0D0G0gqEiA$TCFCA36zEVuLGRDrluY02PaILJ31xLTjou.ADxgI8iWoar98sBUn0m4V06erkBU2UXkJYFVIljXNTv2aRTh4m0";
    };

    root.hashedPassword = "$6$rounds=4096$ZndMwux/UG4xJ6G/$mPu2hJDUbskiuagCddmnd3cogdNgpDk1z9LBWaTOeG8he90oWGW0qgqqGiVUSAxyiQaxheCm4sNrDqroguiCQ1";
  };

  # Create the user's group
  users.groups.mina = { };
}
