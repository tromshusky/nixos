{ pkgs, ... }:
{
    environment.systemPackages = [ pkgs.gnome.gnome-software ];
    services.flatpak.enable = true;
    systemd.services.flatpak-repo.path = [ pkgs.flatpak ];
    systemd.services.flatpak-repo.script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    systemd.services.flatpak-repo.wantedBy = [ "multi-user.target" ];
}
