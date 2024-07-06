{ config, lib, pkgs, ... }:
let
  rockchip = (builtins.getFlake "github:nabam/nixos-rockchip/8eefcf2e47ddf9d97aa573f829cc72b28bcb65f0");
in {
  boot.kernelPackages = rockchip.legacyPackages."x86_64-linux".kernel_linux_6_9_pinetab; # "x86_64-linux" using the precompiled kernel on cachix
  boot.loader.generic-extlinux-compatible.enable = true; # required to write boot entries
  boot.loader.grub.enable = false; # grub doesnt work on pinetab2

  environment.etc."nixos/backup".source = "${./.}"; # backup configuration in /etc/nixos/backup

  hardware.firmware = [ rockchip.packages."aarch64-linux".bes2600 ]; # wifi driver
  imports = [ ./hardware-configuration.nix ]; # generated with sudo nixos-generate-config --show-hardware-config

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # required to nixos-rebuild with builtins.getFlake
  nix.settings.substituters = [ "https://nabam-nixos-rockchip.cachix.org" ]; # use cachix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "bes2600-firmware" ]; # bes2600 requires nonfree
  programs.firefox.enable = true;
  programs.firefox.policies.Extensions.Install = [ "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi" "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi" ];
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.enable = true;
  time.timeZone = "Europe/Amsterdam";
  users.users.user1 = {
    hashedPassword = ""; # Starts with empty password
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # modify networks without password
    ];
  };
  virtualisation.waydroid.enable = true; # enable android apps
}

