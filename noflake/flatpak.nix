{ pkgs, ... }:
{

  environment.systemPackages = [ pkgs.gnome.gnome-software ];
  services.flatpak.enable = true;
  systemd.services.configure-flatpak-repo.path = [ pkgs.flatpak ];
  systemd.services.configure-flatpak-repo.script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
  systemd.services.configure-flatpak-repo.wantedBy = [ "multi-user.target" ];

}
