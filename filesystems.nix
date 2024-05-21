{ config, lib, pkgs, modulesPath, ... }:
let
  btrDev = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
in
{
  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7996-1D0B";
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
