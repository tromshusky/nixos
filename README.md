PREPARE sda1 and sda2 before installing!

```sudo nixos-generate-config --no-filesystems --show-hardware-config | tee hardware-configurations/DEVICENAME.nix```

examples

```sudo nixos-rebuild boot .#macbookpro7-1 --no-write-lock-file```

```sudo nixos-rebuild boot github:tromshusky/nixos#macbookpro7-1 --no-write-lock-file```
