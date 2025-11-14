# NixOS Flake Restructuring Plan

## Overview
This document outlines the plan to restructure the NixOS flake configuration from a flat structure to a role-based model with shared modules and host-specific configurations.

## Current Structure
```
nix-mina/
├── flake.nix
├── hosts/
│   ├── nix-asus/
│   │   ├── configuration.nix
│   │   ├── hardware/
│   │   └── modules/
│   └── nixos-lnvo/
│       ├── hardware/
│       └── modules/
└── shared/
    └── modules/
```

## Target Structure
```
nix-mina/
├── flake.nix                          # Defines hosts, imports, specialArgs
├── shared/
│   ├── modules/
│   │   ├── packages.nix              # Pure software (utils, fonts, themes, NO hardware libs)
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
    │       ├── packages.nix          # NVIDIA libs (xorg.xorgserver, libX*, etc.)
    │       └── services.nix          # MangoWM service, display manager
    └── nixos-lnvo/
        ├── configuration.nix         # Imports: shared + hardware + overrides
        ├── hardware.nix              # Disk UUIDs, Intel GPU, systemd-boot, ZRAM swap
        └── modules/
            ├── services.nix          # power-profiles-daemon, logind, acpid
            └── packages.nix          # (empty placeholder for laptop-specific packages)
```

## Implementation Steps

### 1. Create Shared Modules
- Extract common packages (non-hardware specific)
- Extract common programs configuration
- Extract common services (pipewire, etc.)
- Extract common system settings

### 2. Create Shared Home Manager Configurations
- Extract MangoWM configuration
- Extract fish shell configuration
- Extract kitty terminal configuration
- Extract starship prompt configuration
- Extract direnv and neovim configurations

### 3. Create Host-Specific Configurations
- Desktop (nix-asus): NVIDIA hardware, GRUB, gaming packages
- Laptop (nixos-lnvo): Intel GPU, systemd-boot, power management

### 4. Update flake.nix
- Update module imports to use new structure
- Maintain specialArgs for nixpkgs versions
- Ensure proper host definitions

## Key Changes

### Laptop Migration (nixos-lnvo)
- Remove GNOME configuration (services.xserver.displayManager.gdm, services.xserver.desktopManager.gnome)
- Add MangoWM configuration
- Keep systemd-boot (do not convert to GRUB)
- Add power management services
- Add ZRAM swap

### Package Restructuring
- Move hardware-specific packages to host-specific modules
- Keep general packages in shared modules
- Remove xorg.* packages from shared to host-specific

## Migration Strategy
1. First apply changes to desktop (nix-asus) to verify MangoWM still works
2. Then apply to laptop (nixos-lnvo) with nixos-rebuild test first
3. Verify all functionality works before finalizing