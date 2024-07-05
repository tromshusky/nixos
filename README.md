example nixos configuration for pinetab2

a backup of the configuration is found in /etc/nixos/backup after installation
the standard user is called guest with an empty password.
the password can be changed by opening Xterm and entering ```passwd```

usage: put all these files in an empty folder
(or git clone)
```git clone https://github.com/tromskusky/nixos/tree/pinetab2-minimal```
hardware-configuration.nix and configraution.nix are the usual configurations. feel free to edit them (and/or remove ./config from flake.nix)

prepare your partition layout in /mnt

make sure you have internet connection

install nixos:
```sudo nixos-install --flake .#pt2```
