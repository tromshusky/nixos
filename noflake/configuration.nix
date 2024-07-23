{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
let
  out =
    firefox
    // users
    // amsterdam
    // backup
    // flakes
    // standardDesktop
    // {
      environment.etc."nixos/backup/noflake".source = "${./.}";
      environment.etc."nixos/backup/flake.nix".source = "${../flake.nix}";
      system.stateVersion = "24.05";
      environment.systemPackages = [
        pkgs.git
        pkgs.kitty
        pkgs.librewolf
        pkgs.thunderbird
        pkgs.gnomeExtensions.dash-to-dock
        pkgs.vim
      ];
      imports = [ home-manager.nixosModules.default ];
    };
  standardDesktop = {
    services.xserver.enable = lib.mkDefault true;
    services.xserver.desktopManager.gnome.enable = lib.mkDefault true;
    services.xserver.displayManager.gdm.enable = lib.mkDefault true;
    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = lib.mkDefault [ pkgs.gnome-tour ];
    services.xserver.excludePackages = lib.mkDefault [ pkgs.xterm ];
  };
  amsterdam.time.timeZone = "Europe/Amsterdam";
  backup = { };
  flakes.nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  waydroid.virtualisation.waydroid.enable = true;
  openssh.services.openssh.enable = true;
  #############################           firefox                 ###################
  firefox.programs.firefox = {
    enable = true;
    policies = {
      Extensions.Install = [
        "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/norsk-bokmål-ordliste/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      ];
      Preferences = {
        "browser.translations.automaticallyPopup".Value = false;
      };
    };
  };
  ############################        specialisations          ####################
  spec.specialisation = {
    #    budgie.configuration.imports = [./desktops/budgie.nix];
    #    cinnamon.configuration.imports = [./desktops/cinnamon.nix];
    #    enlightenment.configuration.imports = [./desktops/enlightenment.nix];
    gnome-full.configuration = gnome;
    hyprland.configuration = hyprland;
    #    pantheon.configuration.imports = [./desktops/pantheon.nix];
    #    plasma6.configuration.imports = [./desktops/plasma6.nix];
    #    xfce.configuration.imports = [./desktops/xfce.nix];
  };
  ###########################            users                #####################
  g = "guest";
  users = {
    services.displayManager.autoLogin.user = "${g}";
    users.users = {
      "guest" = {
        uid = 1001;
        extraGroups = [ "networkmanager" ];
        hashedPassword = "";
        isNormalUser = true;
      };
      "jj" = {
        uid = 1000;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$y$j9T$0OWRTLzJzBoKAqfDw3yWo/$gXjqPP6YcmVc52efQxPaNX/yI3Nx8aioRp5PE6G7Ka/";
        home = "/home/user1";
        isNormalUser = true;
      };
    };
    home-manager.users."${g}" = {
      home.stateVersion = "${config.system.stateVersion}";
      dconf.settings = {
        "com/solus-project/budgie-panel".dark-theme = true;
        "org/cinnamon/desktop/interface".gtk-theme = "Mint-Y-Dark-Aqua";
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        "org/gnome/mutter".dynamic-workspaces = true;
        "org/gnome/mutter".edge-tiling = true;
        "org/gnome/settings-daemon/plugins/color".night-light-enabled = true;
        "org/gnome/settings-daemon/plugins/color".night-light-schedule-automatic = false;
        "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
        "org/gnome/shell".enabled-extensions = [
          ""
          "dash-to-dock@micxgx.gmail.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        ];
        "org/gnome/shell".favorite-apps = [ "firefox.desktop" ];
        "org/x/apps/portal".color-scheme = "prefer-dark";
      };
    };
  };
  budgie = {
    services.xserver.enable = true;
    services.xserver.desktopManager.budgie.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
  };
  cinnamon = {
    services.xserver.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    services.displayManager.defaultSession = "cinnamon";
  };
  enlightenment = {
    services.xserver.enable = true;
    services.xserver.desktopManager.enlightenment.enable = true;
  };
  gnome-mini = {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    services.xserver.excludePackages = [ pkgs.xterm ];
  };
  gnome = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
  hyprland = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    programs.hyprland.enable = true;
    programs.waybar.enable = true;
    programs.nm-applet.enable = true;
    environment.systemPackages = [
      pkgs.rofi-wayland
      pkgs.wofi
      pkgs.kitty
      pkgs.hyprpaper
    ];
  };
  pantheon = {
    services.xserver.enable = true;
    services.xserver.desktopManager.pantheon.enable = true;
    services.pantheon.apps.enable = false;
  };
  plasma6 = {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
  xfce = {
    services.xserver.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
    services.displayManager.defaultSession = "xfce";
  };
in
out
