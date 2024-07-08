# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ohci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/etc/NetworkManager/system-connections" =
    { device = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
      fsType = "btrfs";
      options = [ "subvol=@network-connections" ];
    };

  fileSystems."/var/lib/flatpak" =
    { device = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
      fsType = "btrfs";
      options = [ "subvol=@var-lib-flatpak" ];
    };

  fileSystems."/home/user1" =
    { device = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
      fsType = "btrfs";
      options = [ "subvol=@user1" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7996-1D0B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
