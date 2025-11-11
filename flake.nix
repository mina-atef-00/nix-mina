{
  description = "NixOS configuration for nix-asus";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, mango }: {
    nixosConfigurations.nix-asus = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixpkgs-stable nixpkgs-unstable home-manager mango;
      };
      modules = [
        ./hosts/nix-asus/configuration.nix
        home-manager.nixosModules.home-manager
        mango.nixosModules.mango
        {
          programs.mango.enable = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.mina = {
              # The home.stateVersion option does not have a default and must be set
              home.stateVersion = "25.05";
              home.enableNixpkgsReleaseCheck = false;  # Disable version check due to HM/Nixpkgs version mismatch
              imports = [
                mango.hmModules.mango
              ];
              wayland.windowManager.mango = {
                enable = true;
                settings = ''
                  # Appearance Settings - Catppuccin inspired colors
                  borderpx=3
                  rootcolor=0x1e1e2eff
                  bordercolor=0x313244ff
                  focuscolor=0x89b4faff
                  maximizescreencolor=0x45475aff
                  urgentcolor=0xf38ba8ff
                  scratchpadcolor=0x585b70ff
                  globalcolor=0xb4befe
                  overlaycolor=0xa6adc8ff
                  
                  # Gaps
                  gappih=8
                  gappiv=8
                  gappoh=8
                  gappov=8
                  
                  # Window Effects - Enable blur and shadows with catppuccin look
                  blur=1
                  blur_optimized=1
                  blur_params_num_passes=2
                  blur_params_radius=8
                  blur_params_noise=0.01
                  blur_params_brightness=0.95
                  blur_params_contrast=0.95
                  blur_params_saturation=1.2
                  shadows=1
                  shadows_size=8
                  shadows_blur=12
                  shadowscolor=0x0000040
                  border_radius=10
                  
                  # Animations - Smooth animations
                  animations=1
                  animation_type_open=zoom
                  animation_type_close=fade
                  animation_fade_in=1
                  animation_fade_out=1
                  animation_duration_move=400
                  animation_duration_open=300
                  animation_duration_tag=350
                  animation_duration_close=500
                  animation_curve_open=0.34,1.56,0.64,1
                  animation_curve_move=0.34,1.56,0.64,1
                  animation_curve_tag=0.34,1.56,0.64,1
                  animation_curve_close=0.34,1.56,0.64,1
                  
                  # Scroller Layout as default
                  setlayout=scroller
                  
                  # Scroller Layout Settings
                  scroller_structs=15
                  scroller_default_proportion=0.7
                  scroller_focus_center=0
                  scroller_prefer_center=1
                  edge_scroller_pointer_focus=1
                  scroller_ignore_proportion_single=0
                  scroller_default_proportion_single=0.9
                  scroller_proportion_preset=0.5,0.7,0.9
                  
                  # Keyboard Settings
                  repeat_rate=25
                  repeat_delay=600
                  numlockon=1
                  
                  # Mouse and Trackpad Settings
                  tap_to_click=1
                  tap_and_drag=1
                  drag_lock=0
                  trackpad_natural_scrolling=0
                  disable_while_typing=1
                  left_handed=0
                  middle_button_emulation=0
                  mouse_natural_scrolling=0
                  accel_profile=2
                  accel_speed=0.0
                  scroll_method=1
                  click_method=2
                  
                  # Miscellaneous Settings
                  focus_on_activate=1
                  inhibit_regardless_of_visibility=0
                  focus_cross_monitor=0
                  exchange_cross_monitor=0
                  scratchpad_cross_monitor=0
                  focus_cross_tag=0
                  view_current_to_back=1
                  enable_floating_snap=0
                  snap_distance=10
                  no_border_when_single=0
                  cursor_hide_timeout=0
                  drag_tile_to_tile=0
                  single_scratchpad=1
                  
                  # Keyboard Layout Settings (matching hardware/keyboard.nix)
                  xkb_rules_layout=us,ara
                  xkb_rules_options=grp:win_space_toggle
                  
                  # Key Bindings
                  bind=SUPER,Return,spawn,kitty
                  bind=SUPER+SHIFT,f,spawn,firefox
                  bind=SUPER+q,killclient
                  bind=SUPER+space,focuslast
                  bind=SUPER+j,focusdir,left
                  bind=SUPER+l,focusdir,right
                  bind=SUPER+i,focusdir,up
                  bind=SUPER+k,focusdir,down
                  bind=SUPER+SHIFT+j,exchange_client,left
                  bind=SUPER+SHIFT+l,exchange_client,right
                  bind=SUPER+SHIFT+i,exchange_client,up
                  bind=SUPER+SHIFT+k,exchange_client,down
                  bind=SUPER+f,togglefullscreen
                  bind=SUPER+m,togglefloating
                  bind=SUPER+SHIFT+m,togglemaximizescreen
                  bind=SUPER+o,toggleoverview
                  bind=SUPER+Tab,exchange_stack_client,next
                  bind=SUPER+SHIFT+Tab,exchange_stack_client,prev
                  bind=SUPER+comma,incnmaster,-1
                  bind=SUPER+period,incnmaster,+1
                  bind=SUPER+u,toggle_scratchpad
                  bind=SUPER+r,reload_config
                  bind=SUPER+SHIFT+e,quit
                  
                  # Tag bindings (Super + 1-9 to switch tags)
                  bind=SUPER,1,view,1
                  bind=SUPER,2,view,2
                  bind=SUPER,3,view,3
                  bind=SUPER,4,view,4
                  bind=SUPER,5,view,5
                  bind=SUPER,6,view,6
                  bind=SUPER,7,view,7
                  bind=SUPER,8,view,8
                  bind=SUPER,9,view,9
                  
                  # Move window to tag (Super+Shift+1-9)
                  bind=SUPER+SHIFT,1,tag,1
                  bind=SUPER+SHIFT,2,tag,2
                  bind=SUPER+SHIFT,3,tag,3
                  bind=SUPER+SHIFT,4,tag,4
                  bind=SUPER+SHIFT,5,tag,5
                  bind=SUPER+SHIFT,6,tag,6
                  bind=SUPER+SHIFT,7,tag,7
                  bind=SUPER+SHIFT,8,tag,8
                  bind=SUPER+SHIFT,9,tag,9
                  
                  # Layout bindings
                  bind=SUPER+g,switch_layout,
                  bind=SUPER+t,setlayout,tile
                  bind=SUPER+s,setlayout,scroller
                  bind=SUPER+w,setlayout,monocle
                  
                  # Scroller proportion
                  bind=SUPER+minus,set_proportion,0.5
                  bind=SUPER+plus,set_proportion,0.8
                  bind=SUPER+equal,switch_proportion_preset
                  
                  # Mouse bindings
                  mousebind=SUPER,btn_left,moveresize,curmove
                  mousebind=SUPER,btn_right,moveresize,curresize
                  mousebind=SUPER+CTRL,btn_right,killclient
                  
                  # Axis bindings for scrolling between tags
                  axisbind=SUPER,UP,viewtoleft_have_client
                  axisbind=SUPER,DOWN,viewtoright_have_client
                  
                  # Environment variables
                  env=XCURSOR_SIZE,24
                  env=XCURSOR_THEME,catppuccin-mocha-dark-cursors
                  
                  # Additional environment variables for theming
                  env=GTK_THEME,Catppuccin-Mocha-Standard-Blue-Dark
                  env=ICON_THEME,catppuccin-mocha-blue-standard
                  
                  # Exec commands
                  exec-once=swaybg -i /home/mina/Pictures/wallpaper.jpg
                '';
                autostart_sh = ''
                  # Autostart commands
                  # Notification daemon
                  swaync &
                  
                  # Status bar
                  waybar &
                  
                  # Clipboard manager
                  wl-clipboard & 
                  
                  # Wallpaper
                  swaybg -i /home/mina/Pictures/wallpaper.jpg &
                  
                  # Input method if needed
                  # fcitx5 &

                  # Other startup applications can be added here
                '';
              };
            };
          };
        }
      ];
    };
  };
}