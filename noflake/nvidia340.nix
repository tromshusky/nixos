{config, ...}: {

   nixpkgs.config.nvidia.acceptLicense = true;
   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.opengl.enable = true;
   hardware.nvidia.modesetting.enable = true;
   hardware.nvidia.powerManagement.enable = false;
   hardware.nvidia.powerManagement.finegrained = false;
   hardware.nvidia.open = false;
   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
 
}
