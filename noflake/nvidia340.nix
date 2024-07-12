{ config, ... }:
{

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.opengl.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];

}
