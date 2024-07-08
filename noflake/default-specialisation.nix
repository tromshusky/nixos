({ lib, config, pkgs, ... }: {
  config = lib.mkIf (config.specialisation != {}) {
		services.xserver.enable = true;
		services.xserver.desktopManager.gnome.enable = true;
		services.xserver.displayManager.gdm.enable = true;
		services.gnome.core-utilities.enable = false;
		environment.gnome.excludePackages = [ pkgs.gnome-tour ];
		services.xserver.excludePackages = [ pkgs.xterm ];
  };
})
