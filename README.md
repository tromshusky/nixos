PREPARE sda1 and sda2 before installing!

```bash
sudo nixos-generate-config --no-filesystems --show-hardware-config | tee hardware-configurations/DEVICENAME.nix
```

examples

```bash
sudo nixos-rebuild boot .#macbookpro7-1 --no-write-lock-file
```

```bash
sudo nixos-rebuild boot github:tromshusky/nixos#macbookpro7-1 --no-write-lock-file
```

nixos-rebuild can depend on >10GB ram, so in case 
```bash
free -h
```
```bash
btrfs filesystem mkswapfile --size 20G /nix/swapfilet
swapon swapfilet
```
