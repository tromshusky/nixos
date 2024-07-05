{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  environment.etc."nixos/backup".source = "${./.}";

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Amsterdam";

  services.gnome.core-utilities.enable = false;

   users.users.guest = {
     hashedPassword = "";
     isNormalUser = true;
     extraGroups = [ "wheel" "networking" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
}

