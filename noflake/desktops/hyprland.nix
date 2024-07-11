{ pkgs, ... }:
{
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
}
