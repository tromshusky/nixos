{
    documentation.nixos.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    environment.systemPackages = [ pkgs.nautilus ];
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    services.gnome.core-apps.enable = false:
}