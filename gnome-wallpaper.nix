{ config, lib, pkgs, modulesPath, ... }:
let
  christmas-photo-dark.sha256 = "19mr1ynhnzl0fg5hg26nb92969h6am25mzhyg6kmgn4b3yig9yw5";
  christmas-photo-dark.url = "https://cdn.pixabay.com/photo/2024/11/19/00/04/wallpaper-9207726_1280.png";
  white-dog-eye-light.sha256 = "03b2sm25z9dsi58ijrak10h5m6fngzwwcnwwrd6pacc6fycbc944";
  white-dog-eye-light.url = "https://free-images.com/or/d628/wolf_2_9.jpg";
  black-dog-eye-dark.sha256 = "1lysna0m7cg9ka7ls7zjhyq704z91r0v8478a7licqvp5cb5wz7g";
  black-dog-eye-dark.url = "https://p2.piqsels.com/preview/808/37/320/dark-night-dog-puppy.jpg";
  puppy-photo-light.sha256 = "0xgqb9jjfx4b9vc4wikzshwlb5lj2mvqn0nhnxczsa2639f5458l";
  puppy-photo-light.url = "https://images.pexels.com/photos/3640877/pexels-photo-3640877.jpeg";

  default-light = builtins.fetchurl white-dog-eye-light;
  default-dark = builtins.fetchurl black-dog-eye-dark;

  dconf1.settings."org/gnome/desktop/background".picture-uri = "file://${default-light}";
  dconf1.settings."org/gnome/desktop/background".picture-uri-dark = "file://${default-dark}";
in
{
  programs.dconf.profiles.user.databases = [ dconf1 ];
}