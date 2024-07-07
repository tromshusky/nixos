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
  environment.etc."nixos/backup".source = "${./.}";
  environment.systemPackages = [
    pkgs.git
    pkgs.kitty
    pkgs.librewolf
    pkgs.thunderbird
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.vim
  ];
  imports = [
    home-manager.nixosModules.default
    ./default-specialisation.nix
    ./firefox.nix
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
  system.autoUpgrade = {
    enable = true;
#    flake = "${./flake.nix}";
  };
  system.stateVersion = "24.05";
# services.automatic-timezoned.enable = true;
  time.timeZone = "Europe/Amsterdam";
}
