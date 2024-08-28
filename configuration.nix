{
  hostName,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    _hostnameDevice
    _myConfig
    antiBork
    gnome-desktop
    gnome-login
    norway
    plymouth
    waydroid
    { services.openssh.enable = true; }
    { system.stateVersion = "24.11"; }
  ];

  _hostName = _ifFlakeElse hostName _noflakeHostName;
  _hostnameDevice.imports = [ devices."${_hostName}" ];
  _hostnameDevice.networking.hostName = _hostName;
  _ifFlakeElse = flake: noFlake: if lib.inPureEvalMode then flake else noFlake;
  _myConfig.documentation.nixos.enable = false;
#  _myConfig.nix.settings.experimental-features = [ "nix-command flakes" ];
  _myConfig.services.displayManager.autoLogin.user = "guest";
  _myConfig.users.users.guest.extraGroups = [ "wheel" ];
  _myConfig.users.users.guest.hashedPassword = "";
  _myConfig.users.users.guest.home = "/guest";
  _myConfig.users.users.guest.isNormalUser = true;
  _noflakeHostName = lib.fileContents "/etc/hostname";
  antiBork.environment.etc."nixos/backup".source = "${./.}";
  antiBork.system.copySystemConfiguration = _ifFlakeElse false true;
  antiBork.users.users.root.password = "asd";
  devices-dell-btr = "/dev/disk/by-uuid/5fec2288-22ae-4871-baf6-8548f419b831";
  devices.dell.boot.initrd.availableKernelModules = lib.splitString " " "xhci_pci ehci_pci ahci sd_mod sdhci_pci";
  devices.dell.boot.kernelModules = [ "kvm-intel" ];
  devices.dell.boot.loader.efi.canTouchEfiVariables = true;
  devices.dell.boot.loader.systemd-boot.enable = true;
  devices.dell.fileSystems."/".device = "tmpfs";
  devices.dell.fileSystems."/".fsType = "tmpfs";
  devices.dell.fileSystems."/boot".device = "/dev/disk/by-uuid/51EA-5511";
  devices.dell.fileSystems."/boot".fsType = "vfat";
  devices.dell.fileSystems."/boot".options = [ "fmask=0022 dmask=0022" ];
  devices.dell.fileSystems."/nix".device = devices-dell-btr;
  devices.dell.fileSystems."/nix".fsType = "btrfs";
  devices.dell.fileSystems."/nix".options = [ "subvol=nixos/@nix" ];
  devices.dell.fileSystems."/nix/var".device = devices-dell-btr;
  devices.dell.fileSystems."/nix/var".fsType = "btrfs";
  devices.dell.fileSystems."/nix/var".options = [ "subvol=nixos/@nix-var" ];
  devices.dell.hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  devices.dell.imports = [ gnome-desktop ];
  devices.dell.networking.useDHCP = lib.mkDefault true;
  devices.dell.nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  devices.macbookpro71.boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  devices.macbookpro71.boot.initrd.availableKernelModules = lib.splitString " " "ohci_pci ehci_pci ahci firewire_ohci usb_storage usbhid sd_mod sr_mod";
  devices.macbookpro71.boot.kernelModules = lib.splitString " " "kvm-intel wl";
  devices.macbookpro71.boot.loader.efi.canTouchEfiVariables = true;
  devices.macbookpro71.boot.loader.systemd-boot.enable = true;
  devices.macbookpro71.fileSystems."/".device = "tmpfs";
  devices.macbookpro71.fileSystems."/".fsType = "tmpfs";
  devices.macbookpro71.fileSystems."/boot".device = "/dev/disk/by-uuid/7996-1D0B";
  devices.macbookpro71.fileSystems."/boot".fsType = "vfat";
  devices.macbookpro71.fileSystems."/boot".options = lib.splitString " " "fmask=0022 dmask=0022";
  devices.macbookpro71.fileSystems."/nix".device = devicesMacbookpro71Btr;
  devices.macbookpro71.fileSystems."/nix".fsType = "btrfs";
  devices.macbookpro71.fileSystems."/nix".options = lib.splitString " " "subvol=@nix";
  devices.macbookpro71.fileSystems."/nix/var".device = devicesMacbookpro71Btr;
  devices.macbookpro71.fileSystems."/nix/var".fsType = "btrfs";
  devices.macbookpro71.fileSystems."/nix/var".options = lib.splitString " " "subvol=@nix-var";
  devices.macbookpro71.hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  devices.macbookpro71.imports = builtins.attrValues devices.macbookpro71_imports;
  devices.macbookpro71.networking.useDHCP = lib.mkDefault true;
  devices.macbookpro71.nixpkgs.config.allowUnfreePredicate = pkg: (lib.getName pkg) == "broadcom-sta";
  devices.macbookpro71.nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  devices.macbookpro71.services.udev.extraRules = ''ACTION=="add", SUBSYSTEM=="usb", RUN+="${pkgs.bash}/bin/bash -c 'echo 200 > /sys/class/leds/smc\:\:kbd_backlight/brightness'"'';
  devices.macbookpro71.services.xserver.xkb.variant = "mac,";
  devices.macbookpro71_imports.gn-d = gnome-desktop;
  devices.macbookpro71_imports.ovlr = devicesMacbookpro71OverlayRoot;

  devices.pinetab2.systemd.user.services.volume-100.enable = true;
  devices.pinetab2.systemd.user.services.volume-100.script = "${pkgs.alsa-utils}/bin/amixer -c 'rk817ext' set Master 95%";
  devices.pinetab2.systemd.user.services.volume-100.wantedBy = [ "default.target" ]; 

  devices.pinetab2.hardware.sensor.iio.enable = true;
  devices.pinetab2.boot.kernelParams = [ "plymouth.ignore-serial-consoles" ];

  devices.pinetab2.boot.consoleLogLevel = 0;
  devices.pinetab2.boot.kernelPackages = rockchip.legacyPackages."aarch64-linux".kernel_linux_6_9_pinetab;
  devices.pinetab2.boot.loader.generic-extlinux-compatible.enable = true; # Enables the generation of /boot/extlinux/extlinux.conf
  devices.pinetab2.boot.loader.grub.enable = false;
  devices.pinetab2.fileSystems."/".device = "tmpfs";
  devices.pinetab2.fileSystems."/".fsType = "tmpfs";
  devices.pinetab2.fileSystems."/boot".device = "/dev/disk/by-uuid/edebb520-8252-4bad-91ef-9f4d49f73d34";
  devices.pinetab2.fileSystems."/boot".fsType = "ext4";
  devices.pinetab2.fileSystems."/nix".device = devicesPinetab2Btr;
  devices.pinetab2.fileSystems."/nix".fsType = "btrfs";
  devices.pinetab2.fileSystems."/nix".options = [ "subvol=nixos/@nix" ];
  devices.pinetab2.fileSystems."/nix/var".device = devicesPinetab2Btr;
  devices.pinetab2.fileSystems."/nix/var".fsType = "btrfs";
  devices.pinetab2.fileSystems."/nix/var".options = [ "subvol=nixos/@nix-var" ];
  devices.pinetab2.hardware.firmware = [ rockchip.packages."aarch64-linux".bes2600 ]; # wifi driver
  devices.pinetab2.imports = builtins.attrValues devices.pinetab2_imports;
  devices.pinetab2.networking.useDHCP = lib.mkDefault true;
  devices.pinetab2.nix.settings.substituters = [ "https://pinetab2-kernel.cachix.org" ]; # use cachix
  devices.pinetab2.nix.settings.trusted-public-keys = [ "pinetab2-kernel.cachix.org-1:r8erDoAtfeVqWYnmuvdus/PhDEqLVrg90UHM9p9c4b8=" ];
  devices.pinetab2.nixpkgs.config.allowUnfreePredicate = pkg: (lib.getName pkg) == "bes2600-firmware"; # bes2600 requires nonfree
  devices.pinetab2.nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  devices.pinetab2_imports.devicesPinetab2OverlayRoot = devicesPinetab2OverlayRoot;
  devices.pinetab2_imports.phosh-desktop = phosh-desktop;
  devicesMacbookpro71Btr = "/dev/disk/by-uuid/d5177e1d-5956-436b-b6ef-40071e5fece5";
  devicesMacbookpro71OverlayRoot = overlayRoot devicesMacbookpro71OverlayRootArgs;
  devicesMacbookpro71OverlayRootArgs.mountLowerCommand = mountPoint: "mount ${devicesMacbookpro71Btr} -o subvol=@base ${mountPoint}";
  devicesMacbookpro71OverlayRootArgs.persistentDirs = th.persistentDirs;
  devicesPinetab2Btr = "/dev/disk/by-uuid/94a02f18-34ac-41e8-9d71-591f262764c6";
  devicesPinetab2OverlayRoot = overlayRoot devicesPinetab2OverlayRootArgs;
  devicesPinetab2OverlayRootArgs.mountLowerCommand = mountPoint: "mount ${devicesPinetab2Btr} -o subvol=nixos/@base ${mountPoint}";
  devicesPinetab2OverlayRootArgs.persistentDirs = th.persistentDirs;
  gnome-desktop.environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  gnome-desktop.programs.dconf.profiles.user.databases = [ gnome-desktop_Dconf ];
  gnome-desktop.services.gnome.core-utilities.enable = false;
  gnome-desktop.services.xserver.desktopManager.gnome.enable = true;
  gnome-desktop_Dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  gnome-desktop_Dconf.settings."org/gnome/mutter".dynamic-workspaces = true;
  gnome-desktop_Dconf.settings."org/gnome/mutter".edge-tiling = true;
  gnome-desktop_Dconf.settings."org/gnome/shell".favorite-apps = [ "firefox.desktop" ];
  gnome-login.services.xserver.displayManager.gdm.enable = true;
  gnome-login.services.xserver.enable = true;
  gnome-login.services.xserver.excludePackages = [ pkgs.xterm ];
  gnome-login.systemd.services."autovt@tty1".enable = false; # bug workaround for autologin
  gnome-login.systemd.services."getty@tty1".enable = false; # bug workaround for autologin
  norway.time.timeZone = "Europe/Amsterdam";

  phosh-desktop_nopin = pkgs.phosh.overrideAttrs (finalAttrs: oldAttrs: { unpackPhase = "tar -xJf $src;cd ${oldAttrs.pname}-${oldAttrs.version};${pkgs.patch}/bin/patch -p1 -F100 --verbose < ${phosh-desktop_patch};"; });
  phosh-desktop_patch = builtins.toFile "phosh.patch" "--- a/src/lockscreen.c\n+++ b/src/lockscreen.c\n@@ -286,1 +286,1 @@\n-  if (authenticated) {\n+  if (TRUE) {\n";
  phosh-desktop.environment.sessionVariables."GTK_THEME" = "Adwaita:dark"; # why ugly?
  phosh-desktop.services.displayManager.defaultSession = "phosh";

  phosh-desktop.environment.etc."phosh/phoc.ini".text = lib.mkForce "[output:DSI-1]\nscale = 1.25";
  phosh-desktop.services.xserver.desktopManager.phosh.enable = true;
  phosh-desktop.services.xserver.desktopManager.phosh.group = "users";
  phosh-desktop.services.xserver.desktopManager.phosh.user = "guest";
  phosh-desktop.services.xserver.desktopManager.phosh.package = phosh-desktop_nopin;
  phosh-desktop.systemd.services.phosh.wantedBy = lib.mkForce [ ];
  plymouth.boot.plymouth.enable = true;  

  
  rockchip = builtins.getFlake "github:nabam/nixos-rockchip/8eefcf2e47ddf9d97aa573f829cc72b28bcb65f0";
  th.persistentDirs = lib.splitString " " "/etc/NetworkManager/system-connections /guest/.local/share/waydroid /home /root/.cache/nix /var/lib/flatpak /var/lib/waydroid";
  waydroid.virtualisation.waydroid.enable = true;


  overlayRoot =
    {
      mountLowerCommand ? (mountPoint: ""),
      mountUpperCommand ? (mountPoint: "mount -t tmpfs tmpfs ${mountPoint}"),
      persistentDirs ? [ ],
    }:
    {
      boot.initrd.availableKernelModules = [ "overlay" ];
      boot.initrd.kernelModules = [ "overlay" ];
      boot.initrd.postMountCommands =
        let
          rt = "/mnt-root";
          lw = "${rt}-underlay";
          up = "${rt}-overlay";
          nixStoreBind = "/mnt-nix-store-bind";
        in
        ''
          mkdir ${nixStoreBind}
          mount -o bind ${rt}/nix/store ${nixStoreBind}
          ## now: fileSystems are already mounted inside ${rt}, which will become '/' and then the kernel calls the init script
          mkdir -p ${lw} ${up} || echo fail: mkdir ${lw} ${up} failed
          ${mountLowerCommand lw} || echo fail: mount lower failed
          ${mountUpperCommand up} || echo fail: mount upper failed
          mkdir -p ${up}/work ${up}/up || echo fail: mkdir work/up failed
          mount -t overlay overlay -o lowerdir=${lw},workdir=${up}/work,upperdir=${up}/up ${rt} || echo fail: mount overlay failed
          ## now we mount subvolumes for persistent directories, create dirs if not existent
          mkdir -p ${lw}${builtins.concatStringsSep " ${lw}" persistentDirs} || echo fail: mkdir persistentDirs failed
          ${builtins.concatStringsSep "\n" (map (i: "mount -o bind ${lw}${i} ${rt}${i}") persistentDirs)}
          ## we have to mount /nix/store again otherwise init script cant be found
          mkdir -p ${rt}/nix/store
          mount -o bind ${nixStoreBind} ${rt}/nix/store
          ## (all?) other mounts will later be remounted by nixos
        '';
    };

in
{
  inherit imports;
}
