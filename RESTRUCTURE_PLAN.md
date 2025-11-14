# NixOS Flake Restructuring Plan: Migrate Laptop to MangoWM & Modularize Architecture

## Overview

This document details the restructuring of the `nix-mina` repository from a flat configuration to a role-based, modular architecture. The primary goals were to migrate the laptop from GNOME to MangoWM and to create a maintainable, scalable configuration structure.

## Repository Structure Before Restructuring

```
nix-mina/
├── flake.nix
├── hosts/
│   ├── nix-asus/
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   └── nixos-lnvo/
│       ├── configuration.nix
│       └── hardware-configuration.nix
└── README.md
```

## Repository Structure After Restructuring

```
nix-mina/
├── flake.nix                          # Defines hosts, imports, specialArgs
├── shared/
│   ├── modules/
│   │   ├── packages.nix              # Pure software (utils, fonts, themes, NO hardware libs)
│   │   ├── programs.nix              # Git, fish, nix settings
│   │   ├── services.nix              # Base services (pipewire, printing=false)
│   │   ├── system.nix                # Locale, timezone, stateVersion
│   │   └── users.nix                 # User account configuration
│   └── home/mina/
│       ├── mango.nix                 # MangoWM settings (shared)
│       ├── fish.nix                  # Shell aliases and abbreviations
│       ├── kitty.nix                 # Terminal config
│       ├── starship.nix              # Prompt theme
│       ├── direnv.nix                # Direnv configuration
│       └── neovim.nix                # Neovim configuration
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

## Key Changes Implemented

### 1. Repository Restructuring

- **Shared Modules**: Created `shared/modules/` directory containing common configurations used by both hosts
- **Shared Home Manager Configs**: Created `shared/home/mina/` directory with user-specific configurations
- **Host-Specific Directories**: Organized each host with dedicated directories containing hardware and module configurations
- **Modular Architecture**: Separated concerns by functionality and host-specific requirements

### 2. Laptop Migration from GNOME to MangoWM

- **Removed GNOME**: Eliminated all GNOME references (`services.xserver.displayManager.gdm`, `desktopManager.gnome`)
- **Added MangoWM**: Included `mango.nixosModules.mango` to laptop imports
- **Configured MangoWM**: Set `programs.mango.enable = true` for laptop
- **Preserved Bootloader**: Kept systemd-boot on laptop (did NOT convert to GRUB as initially planned)
- **Autostart Applications**: Ensured shared autostart apps (waybar, swaync, wl-clipboard, swaybg) work on both hosts

### 3. Hardware-Specific Configurations

#### Desktop (nix-asus/hardware.nix)
- **NVIDIA Configuration**:
  ```nix
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    forceFullCompositionPipeline = true;
  };
  ```
- **Bootloader**: GRUB with EFI support
- **Disk UUIDs**: Preserved existing partitioning

#### Laptop (nixos-lnvo/hardware.nix)
- **Intel GPU Configuration**:
  ```nix
  hardware.opengl = {
    enable = true;
    enable32Bit = true; # Updated from deprecated driSupport32Bit
  };
  ```
- **Bootloader**: systemd-boot (preserved as requested)
- **Disk UUIDs**: Preserved existing partitioning
- **ZRAM Swap**:
  ```nix
 zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # 50% of available RAM as compressed swap
  };
  ```

### 4. Power Management for Laptop

In `hosts/nixos-lnvo/modules/services.nix`:
```nix
services = {
  power-profiles-daemon.enable = true;

  logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  acpid.enable = true;
};
```

### 5. Package Management Refinement

#### Shared Packages (`shared/modules/packages.nix`)
- Contains all common system packages
- Includes development tools, utilities, browsers, media applications
- Includes xorg packages and gaming packages (moved from desktop-specific to shared)

#### Host-Specific Packages
- `hosts/nix-asus/modules/packages.nix`: Contains NVIDIA-specific packages
- `hosts/nixos-lnvo/modules/packages.nix`: Empty placeholder for future laptop-specific packages

### 6. Home Manager Configuration Modularization

Extracted from the original `flake.nix` into separate files:
- `shared/home/mina/mango.nix`: MangoWM configuration
- `shared/home/mina/fish.nix`: Fish shell configuration
- `shared/home/mina/kitty.nix`: Kitty terminal configuration
- `shared/home/mina/starship.nix`: Starship prompt configuration
- `shared/home/mina/direnv.nix`: Direnv configuration
- `shared/home/mina/neovim.nix`: Neovim configuration

### 7. Flake Configuration Update

- **Special Args**: Maintained `nixpkgs-stable` and `nixpkgs-unstable` inputs
- **Host Imports**: Each host now imports:
  1. `./shared/modules/*` (shared system configurations)
  2. `./shared/home/mina/*` (shared home manager configurations)
 3. `./hosts/{hostname}/hardware.nix` (host-specific hardware)
  4. `./hosts/{hostname}/modules/*` (host-specific modules)
- **Home Manager**: Uses shared home modules via home-manager imports
- **SSH Port**: Maintained as 2200 in global networking config

### 8. Migration Considerations

#### Laptop-Specific Changes
- **Bootloader**: Preserved systemd-boot as requested (contrary to initial plan to switch to GRUB)
- **GPU Drivers**: Removed all NVIDIA references, kept only Intel GPU configuration
- **Power Management**: Added power profiles, lid switch handling, and ACPI support
- **Swap**: Implemented ZRAM instead of traditional swap file

#### Desktop-Specific Changes
- **GPU Drivers**: Maintained NVIDIA configuration with updated package reference
- **Bootloader**: Kept GRUB as the bootloader
- **Swap**: Maintained existing swap file configuration

### 9. Verification Steps

1. **Build Verification**: Confirmed that both configurations build successfully
2. **MangoWM Functionality**: Verified that MangoWM starts properly on both hosts
3. **Service Configuration**: Ensured all required services are properly enabled
4. **Package Availability**: Confirmed all necessary packages are available on both hosts
5. **User Configuration**: Verified that all home manager configurations work correctly

### 10. Constraints and Requirements Met

- ✅ **Preserved Disk Partitioning**: Did not modify existing partitioning on laptop
- ✅ **Maintained systemd-boot**: Laptop continues to use systemd-boot as requested
- ✅ **Preserved User Configs**: All fish aliases, kitty bindings, and Mango settings maintained
- ✅ **Manual Deployment Workflow**: Kept git pull + rebuild workflow
- ✅ **ZRAM Swap**: Added ZRAM without touching existing swap config
- ✅ **SSH Port**: Set SSH to port 2200 consistently
- ✅ **Removed NVIDIA References**: Laptop config no longer contains NVIDIA references

## Migration Plan

### Phase 1: Desktop Configuration
1. Applied changes to desktop host (nix-asus)
2. Verified MangoWM still works correctly
3. Confirmed all existing functionality preserved

### Phase 2: Laptop Migration
1. Applied to laptop (nixos-lnvo) with `nixos-rebuild test` first
2. Verified MangoWM starts without GNOME
3. Confirmed power management works (suspend on lid close)
4. Ensured audio, networking, and display function correctly
5. Verified Waybar and swaync autostart properly

## Future Considerations

- The modular structure makes it easy to add new hosts
- Host-specific packages can be added as needed
- Shared configurations can be updated once and applied to all hosts
- The architecture supports both Wayland and X11 applications
- Power management is properly configured for laptop use

## Conclusion

The repository has been successfully restructured to meet all requirements. The laptop has been migrated from GNOME to MangoWM while preserving all existing configurations and functionality. The new modular architecture provides a solid foundation for future expansion and maintenance.