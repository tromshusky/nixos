{ config, home-manager, ... }:
{
  users.users = {
    "${config._module.args.guestUserName}" = {
      uid = 1001;
      extraGroups = [ "networkmanager" ];
      hashedPassword = "";
      isNormalUser = true;
    };
    "${config._module.args.powerUserName}" = {
      uid = 1000;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      hashedPassword = "$y$j9T$0OWRTLzJzBoKAqfDw3yWo/$gXjqPP6YcmVc52efQxPaNX/yI3Nx8aioRp5PE6G7Ka/";
      home = "${config._module.args.powerUserHome}";
      isNormalUser = true;
    };
  };
  home-manager.users."${config._module.args.guestUserName}" = {
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
      ];
      "org/gnome/shell".favorite-apps = [ "firefox.desktop" ];
      "org/x/apps/portal".color-scheme = "prefer-dark";
    };
  };
  #  home-manager.users."${config._module.args.powerUserName}".home = {
  #    stateVersion = "${config.system.stateVersion}";
  #  };
}
