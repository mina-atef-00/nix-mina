{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    wget
    curl
    vim
    htop
    bottom
    ripgrep
    fd
    fzf
    bat
    eza
    dust
    jq
    yq
    zip
    unzip
    tree
    file
    nix-index
    nix-tree
    gitoxide

    # Terminal and shell
    fish
    starship
    direnv
    gvfs
    libinput
    kitty
    zellij

    # Development tools
    nodejs
    nodePackages.npm
    nodePackages.yarn
    python3
    python311Packages.pip
    gcc
    gnumake
    cmake
    glibc
    plymouth

    # Media and graphics
    mpv
    ffmpeg
    ffmpegthumbnailer
    imagemagick

    # Browsers
    firefox

    # Communication
    vesktop

    # Gaming packages (moved from desktop-specific to shared as requested)
    steam
    SDL2
    protontricks
    mangohud
    goverlay
    gamemode

    libusb1
    udev

    # Additional libraries for better compatibility
    # xorg packages now included as requested (moved from desktop-specific to shared)
    xorg.xorgserver
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXrender
    xorg.libXext
    xorg.setxkbmap

    # Input diagnostic tools
    xorg.xev
    evtest
    brightnessctl
    mesa-demos
    duf
    dysk
    file-roller
    eog
    inxi
    killall
    libnotify
    libdrm
    lshw
    ncdu
    nixfmt-rfc-style
    nixd
    nil
    sox
    libxkbcommon
    pixman
    meson
    ninja
    hwdata
    seatd
    libliftoff
    pcre2
    libdisplay-info
    usbutils
    v4l-utils
    gum
    gtk3
    gtk4
    pciutils
    dconf
    # Fix for Xwayland symbol errors
    libkrb5
    keyutils

    # Productivity
    obsidian
    thunderbird
    libreoffice

    # Audio/video
    pavucontrol
    playerctl

    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.tumbler

    # File management
    p7zip

    # Security
    gnupg
    age
    openssl

    # Wayland utilities
    wayland-protocols
    wl-clipboard
    # Additional Wayland support
    xwayland
    wlr-randr
    grim
    slurp
    swappy

    # GTK themes
    colloid-gtk-theme

    # Icon themes
    papirus-icon-theme

    # Cursor themes
    numix-cursor-theme

    # Adobe Source Han Sans/Serif (CJK fonts)
    source-han-sans
    source-han-serif

    # Liberation fonts
    liberation_ttf

    # Noto fonts (Google's font family)
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin

    # Ubuntu fonts
    ubuntu-sans

    # GNU FreeFont
    freefont_ttf

    # WenQuanYi fonts (Chinese)
    wqy_zenhei
    wqy_microhei

    # Additional useful fonts
    fira-code
    fira-code-symbols
    font-awesome

    roboto
    roboto-slab

    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.hack

    inter
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
