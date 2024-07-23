{ ... }:
{
  swapDevices = [
    {
      device = "/nix/swapfile";
      size = 20000;
    }
  ];
}
