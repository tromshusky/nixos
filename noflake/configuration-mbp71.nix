{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
{
  nixpkgs.config.allowUnfree = true; # driver in hardware-configuration is unfree
  imports = [
    ./configuration.nix
    ./hardware-configurations/macbookpro7-1.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;


 #  nixpkgs.config.nvidia.acceptLicense = true;
#   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.opengl.enable = true;
#   hardware.nvidia.modesetting.enable = true;
#   hardware.nvidia.powerManagement.enable = false;
#   hardware.nvidia.powerManagement.finegrained = false;
 #  hardware.nvidia.open = false;
 #  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
 

   systemd.services.configure-flatpak-repo = {
     wantedBy = [ "multi-user.target" ];
     path = [ pkgs.flatpak ];
     script = ''
       flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
     '';
   };
  services.flatpak.enable = true;
  environment.systemPackages = [ pkgs.gnome.gnome-software ];

  services.xserver.xkb.layout = "no,us";
  services.xserver.xkb.variant = "mac,";
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", RUN+="${pkgs.bash}/bin/bash -c 'echo 200 > /sys/class/leds/smc\:\:kbd_backlight/brightness'"
  '';

  swapDevices = [
    {
      device = "/nix/swapfile";
      size = 20000;
    }
  ];

  system.autoUpgrade = {
    enable = true;
    flags = [ "--no-write-lock-file" ];
    flake = "github:tromshusky/nixos#macbookpro7-1";
  };
}
