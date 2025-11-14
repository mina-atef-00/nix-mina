{ config, ... }:
{
  programs.fish = {
    enable = true;
    # Nix-related fish shell aliases for efficient system administration
    shellAbbrs = {
      # Basic navigation
      ll = "ls -la"; # List all files with details
      ".." = "cd .."; # Go up one directory
      "..." = "cd ../.."; # Go up two directories

      # NixOS rebuild commands
      nrc = "sudo nixos-rebuild check --flake .#nixos"; # Check configuration without applying
      nrs = "sudo nixos-rebuild switch --flake .#nixos"; # Apply configuration changes
      nrt = "sudo nixos-rebuild test --flake .#nixos"; # Test configuration without activation
      nrb = "sudo nixos-rebuild build --flake .#nixos"; # Build configuration without activation
      nro = "sudo nixos-rebuild switch --option accept-flake-config true --flake .#nixos"; # Rebuild with config acceptance

      # Home Manager commands
      hms = "home-manager switch --flake .#nixos"; # Apply home manager configuration
      hmb = "home-manager build --flake .#nixos"; # Build home manager configuration
      hmc = "home-manager check --flake .#nixos"; # Check home manager configuration

      # Nix garbage collection and storage management
      ngr = "sudo nix-collect-garbage"; # Clean up unused store paths
      ngk = "sudo nix-collect-garbage -d"; # Remove old generations and unused paths
      ngl = "nix store list-generations"; # List system generations
      ngrm = "sudo nix-store --gc"; # Run garbage collector
      ngrm1 = "sudo nix-store --delete-old"; # Remove generations older than current
      ngrm0 = "sudo nix-store --delete-older-than 1d"; # Remove store paths older than 1 day
      nst = "nix-store --list-generations"; # List nix store generations

      # Nix package management
      ns = "nix search"; # Search for packages
      ni = "nix-env -iA"; # Install package
      nr = "nix-env -e"; # Remove package
      nl = "nix-env -q"; # List installed packages
      nup = "nix-env -u"; # Upgrade packages
      nupall = "nix-env -u '*'"; # Upgrade all packages

      # Nix flake commands
      nf = "nix flake"; # Flake operations
      nfu = "nix flake update"; # Update flake lock file
      nfc = "nix flake check"; # Check flake outputs
      nfb = "nix build"; # Build flake outputs
      nfd = "nix develop"; # Enter development environment
      nsh = "nix shell"; # Enter nix shell environment
      nrm = "nix store delete"; # Delete store paths

      # Nix channel management
      nc = "nix-channel"; # Channel operations
      ncu = "nix-channel --update"; # Update channels
      ncl = "nix-channel --list"; # List channels
      nca = "nix-channel --add"; # Add channel
      ncr = "nix-channel --remove"; # Remove channel

      # System and configuration management
      sysup = "sudo nixos-rebuild switch --upgrade --flake .#nixos"; # Upgrade system and apply config
      syschk = "nix flake check --all-systems --extra-experimental-features 'nix-command flakes'"; # Check flake validity
      sysgc = "sudo nix-collect-garbage && sudo nix-store --gc"; # Full system garbage collection
      sysdf = "nix store optimise"; # Optimize nix store
      # Development shortcuts
      cdnix = "cd ~/nixos-configs"; # Go to nixos configs directory
      vimnix = "nvim ~/nixos-configs"; # Open nixos configs in vim
      gitnix = "cd ~/nixos-configs && git status"; # Check git status of configs
      gitnixup = "cd ~/nixos-configs && git pull origin main && nix flake check"; # Update and check configs
    };
  };
}
