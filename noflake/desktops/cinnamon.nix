{ ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.defaultSession = "cinnamon";
}
