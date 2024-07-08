{ pkgs, ... }: {
	services.xserver.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	services.gnome.core-utilities.enable = false;
	environment.gnome.excludePackages = [ pkgs.gnome-tour ];
	services.xserver.excludePackages = [ pkgs.xterm ];
}
