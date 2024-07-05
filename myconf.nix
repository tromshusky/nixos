{ config, lib, pkgs, ... }: {
  environment.etc."nixos/backup".source = "${./.}";
#  networking.networkmanager.enable =
#    true; # Easiest to use and most distros use this by default.
  programs.firefox.enable = true;
  services.openssh.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  time.timeZone = "Europe/Amsterdam";
  users.users.user1 = {
    hashedPassword = ""; # Starts with empty password
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
  };
  virtualisation.waydroid.enable = true;
}

