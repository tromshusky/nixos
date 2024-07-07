{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}: 
let
  rockchip = (builtins.getFlake "github:nabam/nixos-rockchip/8eefcf2e47ddf9d97aa573f829cc72b28bcb65f0");
in {
  nixpkgs.config.allowUnfree = true; # driver in hardware-configuration is unfree
  imports = [
    ./configuration.nix
    ./hardware-configurations/pinetab2.nix
  ];

  boot.kernelPackages = rockchip.legacyPackages."x86_64-linux".kernel_linux_6_9_pinetab; # "x86_64-linux" using the precompiled kernel on cachix
  boot.loader.generic-extlinux-compatible.enable = true; # required to write boot entries
  boot.loader.grub.enable = false; # grub doesnt work on pinetab2
  hardware.firmware = [ rockchip.packages."aarch64-linux".bes2600 ]; # wifi driver
  nix.settings.substituters = [ "https://nabam-nixos-rockchip.cachix.org" ]; # use cachix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "bes2600-firmware" ]; # bes2600 requires nonfree

  system.autoUpgrade = {
    enable = true;
    flags = [ "--no-write-lock-file" ];
    flake = "github:tromshusky/nixos#pinetab2";
  };
}
