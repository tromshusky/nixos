{ config, lib, pkgs, ... }:
let
  rockchip = (builtins.getFlake "github:nabam/nixos-rockchip/8eefcf2e47ddf9d97aa573f829cc72b28bcb65f0");
in {
  boot.kernelPackages = rockchip.legacyPackages."x86_64-linux".kernel_linux_6_9_pinetab; # "x86_64-linux" using the precompiled kernel on cachix
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.grub.enable = false;
  environment.etc."nixos/backup".source = "${./.}";
  hardware.firmware = [ rockchip.packages."aarch64-linux".bes2600 ];
  imports = [ ./hardware-configuration.nix ];
  nix.settings.substituters = [ "https://cache.nixos.org/" "https://nabam-nixos-rockchip.cachix.org" ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "bes2600-firmware" ];
  programs.firefox.enable = true;
  programs.firefox.policies.Extensions.Install = [ "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi" "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi" ];
  services.openssh.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.enable = true;
  time.timeZone = "Europe/Amsterdam";
  users.users.user1 = {
    hashedPassword = ""; # Starts with empty password
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
  };
  virtualisation.waydroid.enable = true; # enable android apps
}

