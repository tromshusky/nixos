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
    flags = [ "--no-write-lock-file" ];
    flake = "github:tromshusky/nixos#macbookpro7-1";
  };
}
