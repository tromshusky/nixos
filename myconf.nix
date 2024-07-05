{ config, lib, pkgs, ... }: {
  environment.etc."nixos/backup".source = "${./.}";
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.
  programs.firefox.enable = true;
  services.openssh.enable = true;
  time.timeZone = "Europe/Amsterdam";
  users.users.guest = {
    hashedPassword = ""; # Starts with empty password
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
  };
  virtualisation.waydroid.enable = true;
}

