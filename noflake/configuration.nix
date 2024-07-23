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
    // flakes {
      services.xserver.enable = lib.mkDefault true;
      services.xserver.desktopManager.gnome.enable = lib.mkDefault true;
      services.xserver.displayManager.gdm.enable = lib.mkDefault true;
      services.gnome.core-utilities.enable = lib.mkDefault false;
      environment.gnome.excludePackages = lib.mkDefault [ pkgs.gnome-tour ];
      services.xserver.excludePackages = lib.mkDefault [ pkgs.xterm ];
      system.stateVersion = "24.05";
      environment.systemPackages = [
        pkgs.git
        pkgs.kitty
        pkgs.librewolf
        pkgs.thunderbird
        pkgs.gnomeExtensions.dash-to-dock
        pkgs.vim
      ];
      imports = [
        home-manager.nixosModules.default
        ./default-specialisation.nix
      ];
      services.displayManager.autoLogin.user = "${config._module.args.guestUserName}";
    };
  backup = {
    environment.etc."nixos/backup/noflake".source = "${./.}";
    environment.etc."nixos/backup/flake.nix".source = "${../flake.nix}";
  };
  flakes.nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  waydroid.virtualisation.waydroid.enable = true;
  openssh.services.openssh.enable = true;
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
  spec.specialisation = {
    #    budgie.configuration.imports = [./desktops/budgie.nix];
    #    cinnamon.configuration.imports = [./desktops/cinnamon.nix];
    #    enlightenment.configuration.imports = [./desktops/enlightenment.nix];
    gnome-full.configuration.imports = [ ./desktops/gnome.nix ];
    hyprland.configuration.imports = [ ./desktops/hyprland.nix ];
    #    pantheon.configuration.imports = [./desktops/pantheon.nix];
    #    plasma6.configuration.imports = [./desktops/plasma6.nix];
    #    xfce.configuration.imports = [./desktops/xfce.nix];
  };
  g = "guest";
  usr = {
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
in
out
