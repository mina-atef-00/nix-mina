# NixOS Flake Configuration

This repository contains the NixOS configuration for two hosts:
- **Desktop (nix-asus)**: Arch Linux development machine with NVIDIA GPU, running MangoWM
- **Laptop (nixos-lnvo)**: NixOS 25.05 laptop with Intel GPU, running MangoWM

## Repository Structure

```
nix-mina/
├── flake.nix                          # Defines hosts, imports, specialArgs
├── shared/
│   ├── modules/
│   │   ├── packages.nix              # Base software (utils, fonts, themes, xorg, gaming packages)
│   │   ├── programs.nix              # Git, fish, nix settings
│   │   ├── services.nix              # Base services (pipewire, printing=false)
│   │   └── system.nix                # Locale, timezone, stateVersion
│   └── home/mina/
│       ├── mango.nix                 # MangoWM settings (shared)
│       ├── fish.nix                  # Shell aliases and abbreviations
│       ├── kitty.nix                 # Terminal config
│       └── starship.nix              # Prompt theme
└── hosts/
    ├── nix-asus/
    │   ├── configuration.nix         # Imports: shared + hardware + overrides
    │   ├── hardware.nix              # Disk UUIDs, NVIDIA, kernel modules, GRUB
    │   └── modules/
    │       ├── packages.nix          # (empty - all packages now in shared)
    │       └── services.nix          # MangoWM service, display manager
    └── nixos-lnvo/
        ├── configuration.nix         # Imports: shared + hardware + overrides
        ├── hardware.nix              # Disk UUIDs, Intel GPU, GRUB, ZRAM swap
        └── modules/
            ├── services.nix          # power-profiles-daemon, logind, acpid
            └── packages.nix          # (empty placeholder for laptop-specific packages)
```

## Migration Notes

### Laptop Migration from GNOME to MangoWM
- Removed all GNOME references (`services.xserver.displayManager.gdm`, `desktopManager.gnome`)
- Added `mango.nixosModules.mango` to laptop imports
- Configured `programs.mango.enable = true` for laptop
- Changed laptop to use GRUB bootloader (as requested)
- Ensured shared autostart apps (waybar, swaync, wl-clipboard, swaybg) work on both hosts

### Hardware-Specific Configurations
- **Desktop (nix-asus)**: NVIDIA packages, GRUB bootloader
- **Laptop (nixos-lnvo)**: Intel GPU settings, GRUB bootloader, power management, ZRAM swap

### Package Restructuring
- All packages are now in shared modules (as requested)
- No longer have host-specific packages
- Printing service disabled in shared services (enabled only where needed)

## Usage

### Building Configuration
```bash
# Build for desktop
nixos-rebuild build --flake .#nix-asus

# Build for laptop
nixos-rebuild build --flake .#nixos-lnvo
```

### Switching Configuration
```bash
# Apply to desktop
sudo nixos-rebuild switch --flake .#nix-asus

# Apply to laptop
sudo nixos-rebuild switch --flake .#nixos-lnvo
```

### Testing Configuration
```bash
# Test laptop configuration without activation
sudo nixos-rebuild test --flake .#nixos-lnvo
```

## SSH Access
- SSH port has been changed to 2200 for both hosts
- Ensure firewall allows connections on this port

## Key Features
- **MangoWM**: Tiled Wayland window manager on both hosts
- **Power Management**: Laptop has suspend on lid close, power profiles
- **ZRAM**: Laptop uses ZRAM for compressed swap
- **Modular Design**: Shared configurations reduce duplication
- **Hardware Optimization**: Host-specific settings where needed
- **GRUB Bootloader**: Both hosts now use GRUB