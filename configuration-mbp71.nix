{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    ./configuration.nix
    ./hardware-configurations/macbookpro7-1.nix
  ];
  system.autoUpgrade = {
    enable = true;
    flake = "github:tromshusky/nixos#macbookpro7-1";
  };
}
