{ config, lib, pkgs, modulesPath, ... }:
let
  bootDev = "/dev/sda1";
  btrDev = "/dev/sda2";
in
{
  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = bootDev;
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/nix" =
    { device = btrDev;
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."${config._module.args.powerUserHome}" =
    { device = btrDev;
      fsType = "btrfs";
      options = [ "subvol=@user1" ];
    };

  fileSystems."/etc/NetworkManager/system-connections" =
    { device = btrDev;
      fsType = "btrfs";
      options = [ "subvol=@network-connections" ];
    };

  swapDevices = [ ];
}
