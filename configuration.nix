{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}: {
  _module.args = {
    guestUserName = "guest";
    powerUserHome = "/home/user1";
    powerUserName = "jj";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  environment.etc."nixos/backup".source = "${./.}";
  environment.systemPackages = [
    pkgs.git
    pkgs.kitty
    pkgs.librewolf
    pkgs.thunderbird
    pkgs.vim
  ];
  imports = [
    home-manager.nixosModules.default
    ./default-specialisation.nix
    ./filesystems.nix
    ./firefox.nix
    ./hardware-configuration.nix
    ./specialisations.nix
    ./users.nix
  ];
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  nixpkgs.config.allowUnfree = true;
  services.displayManager.autoLogin.user = "${config._module.args.guestUserName}";
  services.openssh.enable = true;
  swapDevices = [ { device = "/nix/swapfile"; size=20000; } ];
  system.autoUpgrade = {
    enable = true;
    flake = "github:tromshusky/nixos";
  };
  system.stateVersion = "24.05";
  time.timeZone = "Europe/Amsterdam";
}
