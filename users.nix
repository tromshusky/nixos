{
  config,
  home-manager,
  ...
}: {
  users.users = {
    "${config._module.args.guestUserName}" = {
      extraGroups = ["networkmanager"];
      hashedPassword = "";
      isNormalUser = true;
    };
    "${config._module.args.powerUserName}" = {
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      hashedPassword = "$y$j9T$0OWRTLzJzBoKAqfDw3yWo/$gXjqPP6YcmVc52efQxPaNX/yI3Nx8aioRp5PE6G7Ka/";
      home = "${config._module.args.powerUserHome}";
      isNormalUser = true;
    };
  };
  home-manager.users."${config._module.args.guestUserName}".dconf.settings = {
    "com/solus-project/budgie-panel".dark-theme = true;
    "org/cinnamon/desktop/interface".gtk-theme = "Mint-Y-Dark-Aqua";
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/gnome/mutter".dynamic-workspaces = true;
    "org/gnome/mutter".edge-tiling = true;
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
    "org/x/apps/portal".color-scheme = "prefer-dark";
  };
}
