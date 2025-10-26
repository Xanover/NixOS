# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
    username = "ashley";
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.ashley = { pkgs, ... }: {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };

    programs.git = {
      enable = true;

      settings = {
	user.name = "Xanover";
	user.email = "40719746+Xanover@users.noreply.github.com";
	# dont use actual email cuz i dont wanna dox myself yk
      };
    };

    programs.kitty = {
      enable = true;

      font = {
        name = "JetBrainsMono Nerd Font";
      };

      settings = {
	cursor_trail = "1";
	enable_audio_bell = "no";
	window_margin_width = "8";
	background_opacity = "0.7";
      };
    };

    programs.neovim = {
      enable = true;
    };

    programs.anyrun = {
      enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = [
          "DP-3, 2560x1440@144, 1920x0, 1.25" 
          "DP-2, 1920x1080@60, 0x0, 1"
        ];

        "$terminal" = "hyprctl dispatch exec '[float; size 1000 510]' kitty";
        "$fileManager" = "dolphin";
        "$menu" = "anyrun";

	general = {
	  gaps_in = "3";
	  gaps_out = "7";

	  border_size = "2";

	  "col.active_border" = "rgba(ffc8ddee) rgba(cdb4dbee) 45deg";
	  "col.inactive_border" = "rgba(595959aa)";

	  layout = "dwindle";
	};

	decoration = {
	  rounding = "10";
	  active_opacity = "1.0";
	  inactive_opacity = "1.0";

	  shadow = {
	    enabled = true;
	    range = "4";
	    render_power = "3";
	    color = "rgba(1a1a1aee)";
	  };

	  blur = {
	    enabled = true;
	    size = "3";
	    passes = "1";

	    vibrancy = "0.1696";
	  };
	};

	dwindle = {
	  pseudotile = true;
	  preserve_split = true;
	};

	master = {
	  new_status = "master";
	};

	misc = {
	  force_default_wallpaper = "1";
	  disable_hyprland_logo = true;
	};

	input = {
	  kb_layout = "us";
	  kb_variant = "";
	  kb_model = "";
	  kb_options = "";
	  kb_rules = "";

	  follow_mouse = "1";

	  sensitivity = "-0.6";
	};

	"$mainMod" = "SUPER";

        bind = [
          "$mainMod, Q, exec, $terminal"
	  "$mainMod, C, killactive,"
	  "$mainMod SHIFT, C, exec, kill -9 $(hyprctl activewindow -j | jq -r '.pid')"
	  "$mainMod, M, exit,"
	  "$mainMod, E, exec, $filemanager"
	  "$mainMod, V, togglefloating,"
	  "$mainMod, R, exec, $menu"
	  "$mainMod, P, pseudo,"
	  "$mainMod, J, togglesplit,"
	  "$mainMod, L, exec, hyprlock"
	  "$mainMod, F, fullscreen"

	  "$mainMod, left, movefocus, l"
	  "$mainMod, right, movefocus, r"
	  "$mainMod, up, movefocus, u"
	  "$mainMod, down, movefocus, d"

	  "$mainMod, 1, workspace, 1"
	  "$mainMod, 2, workspace, 2"
	  "$mainMod, 3, workspace, 3"
	  "$mainMod, 4, workspace, 4"
	  "$mainMod, 5, workspace, 5"
	  "$mainMod, 6, workspace, 6"
	  "$mainMod, 7, workspace, 7"
	  "$mainMod, 8, workspace, 8"
	  "$mainMod, 9, workspace, 9"
	  "$mainMod, 0, workspace, 10"

	  "$mainMod SHIFT, 1, movetoworkspace, 1"
	  "$mainMod SHIFT, 2, movetoworkspace, 2"
	  "$mainMod SHIFT, 3, movetoworkspace, 3"
	  "$mainMod SHIFT, 4, movetoworkspace, 4"
	  "$mainMod SHIFT, 5, movetoworkspace, 5"
	  "$mainMod SHIFT, 6, movetoworkspace, 6"
	  "$mainMod SHIFT, 7, movetoworkspace, 7"
	  "$mainMod SHIFT, 8, movetoworkspace, 8"
	  "$mainMod SHIFT, 9, movetoworkspace, 9"
	  "$mainMod SHIFT, 0, movetoworkspace, 10"

	  "$mainMod SHIFT, LEFT, swapwindow, l"
	  "$mainMod SHIFT, RIGHT, swapwindow, r"
	  "$mainMod SHIFT, UP, swapwindow, u"
	  "$mainMod SHIFT, DOWN, swapwindow, d"

	  "$mainMod, Z, exec, amixer set Capture toggle"

	  "$mainMod SHIFT, mouse_down, exec, rmpc volume +5"
	  "$mainMod SHIFT, mouse_up, exec, rmpc volume -5"
	  ", code:164, exec, rmpc togglepause"

	  "$mainMod, x, exec, hyprshot -m region --clipboard-only"
	  "$mainMod SHIFT, x, exec, hyprshot -m window --clipboard-only"
	  "$mainMod ALT_L, x, exec, hyprshot -m output --clipboard-only"
        ];

	bindm = [
	  "$mainMod, mouse:272, movewindow"
	  "$mainMod, mouse:273, resizewindow"
	];

	bindel = [
	  ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
	  ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	  ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	  ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
	  ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
	  ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
	];

	xwayland = {
	  force_zero_scaling = true;
	};
      };

    # oh great heavens this is awful
    extraConfig = ''
	animations {
    		enabled = yes, please :)

    	# Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more

    		bezier = easeOutQuint,0.23,1,0.32,1
    		bezier = easeInOutCubic,0.65,0.05,0.36,1
    		bezier = linear,0,0,1,1
    		bezier = almostLinear,0.5,0.5,0.75,1.0
    		bezier = quick,0.15,0,0.1,1

    		animation = global, 1, 10, default
    		animation = border, 1, 5.39, easeOutQuint
    		animation = windows, 1, 4.79, easeOutQuint
    		animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    		animation = windowsOut, 1, 1.49, linear, popin 87%
    		animation = fadeIn, 1, 1.73, almostLinear
    		animation = fadeOut, 1, 1.46, almostLinear
    		animation = fade, 1, 3.03, quick
    		animation = layers, 1, 3.81, easeOutQuint
    		animation = layersIn, 1, 4, easeOutQuint, fade
    		animation = layersOut, 1, 1.5, linear, fade
    		animation = fadeLayersIn, 1, 1.79, almostLinear
    		animation = fadeLayersOut, 1, 1.39, almostLinear
    		animation = workspaces, 1, 1.94, almostLinear, fade
    		animation = workspacesIn, 1, 1.21, almostLinear, fade
    		animation = workspacesOut, 1, 1.94, almostLinear, fade
	}


	# Ignore maximize requests from apps. You'll probably like this.
	windowrule = suppressevent maximize, class:.*

	# Fix some dragging issues with XWayland
	windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

	# fix hyprshot black border
	layerrule = noanim, hyprpicker
	layerrule = noanim, selection

	# fix picture in picture
	windowrulev2 = float, title:^(Picture-in-Picture)$
	windowrulev2 = pin, title:^(Picture-in-Picture)$
    '';
    };

    home.packages = with pkgs; [
      htop
    ];
    
    home.stateVersion = "25.05";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ashley = {
    isNormalUser = true;
    description = "ashley";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  firefox
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
