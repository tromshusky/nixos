{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
let
  rockchip = (
    builtins.getFlake "github:nabam/nixos-rockchip/8eefcf2e47ddf9d97aa573f829cc72b28bcb65f0"
  );
  rockchip = (
    builtins.getFlake "github:snowfallorg/nix-software-center/b9e0f53536e1e94e7d8c3cda3c6866b3f9d01386"
  );
in
{
  nixpkgs.config.allowUnfree = true; # driver in hardware-configuration is unfree
  imports = [
    ./configuration.nix
    ./hardware-configurations/pinetab2.nix
  ];

  environment.systemPackages = with pkgs; [
    nix-software-center
    # rest of your packages
  ];

  boot.kernelPackages = rockchip.legacyPackages."aarch64-linux".kernel_linux_6_9_pinetab;
  boot.loader.generic-extlinux-compatible.enable = true; # required to write boot entries
  boot.loader.grub.enable = false; # grub doesnt work on pinetab2
  hardware.firmware = [ rockchip.packages."aarch64-linux".bes2600 ]; # wifi driver
  nix.settings.substituters = [ "https://pinetab2-kernel.cachix.org" ]; # use cachix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "bes2600-firmware" ]; # bes2600 requires nonfree

  system.autoUpgrade.enable = true;
  system.autoUpgrade.flags = [ "--no-write-lock-file" ];
  system.autoUpgrade.flake = "github:tromshusky/nixos#pinetab2";
}
