[take me to installation command](https://github.com/tromshusky/nixos/tree/pinetab2-minimal?tab=readme-ov-file#4-auto-one-line-install-from-sd-card)
# 1. Download image
Download sd-image from [nabam/nixos-rockchip](https://github.com/nabam/nixos-rockchip):

https://github.com/nabam/nixos-rockchip/releases/download/v24.05.20240630.7dca152/pine-tab2-nixos-sd-image-aarch64-linux.img.zst

# 2. Uncompress and copy to sd-card
You open the terminal and unpack the image and flash it to the sd-card. On my pinetab, the sd-card gets recognized as `/dev/mmcblk1`
```bash
lsblk | grep G.*disk
# example:
# mmcblk0 179:0   0 116.5G 0 disk
# mmcblk1 179:96  0  29.5G 0 disk
#################################
```
```bash
sd=/dev/mmcblk1
unzstd ~/Downloads/pine-tab2-nixos-sd-image-aarch64-linux.img.zst | sudo dd bs=1M of=$sd conv=fsync status=progress
```
wait to finish. at the end it may hang for a long time, while the data was already 'send' but not 'received'.

reboot.
# 3. Connect wifi with wpa_supplicant
Wifi psk and password can be found on your phone > Wifi > TimHortons Secret Wifi or whatever > Share
```bash
sudo systemctl start wpa_supplicant
wpa_cli

  add_network
  # CTRL-EVENT-NETWORK-ADDED 0
  set_network 0 ssid "TimHortons Slow Wifi"
  set_network 0 psk "starbucksisacheapcopy"
  enable 0

# Ctrl+C
```

# 4 Auto: One line install (from sd card):
<details>
  <summary>(optional: open browser over sway)</summary>
  
```bash
nix-env -iA nixos.sway nixos.firefox nixos.foot nixos.dmenu
sway # cage -s sway # if that dont work
# Pine+enter on the new screen to open terminal (foot)
swaymsg output "*" transform 90
swaymsg input "*" map_to_output "*"
firefox
# Pine+W or Pine+F for fullscreen
```

</details>

```bash
curl https://raw.githubusercontent.com/tromshusky/nixos/pinetab2-minimal/install.sh | sudo sh
```

# 4 Manual: formatting
<details>
  <summary>(optional: colorful terminal)</summary>
  
```bash
nix-env -iA nixos.fish
fish
```
</details>

format the internal disk and set up partition
```bash
# careful, this is probably not the same as before 
dev1=/dev/mmcblk0
```
```bash
sudo parted $dev1 -- mklabel gpt
sudo parted $dev1 -- mkpart ESP ext4 18MB 100%
sudo parted $dev1 -- set 1 esp on
sudo mkfs.ext4 $dev1"p1"
```
mount filesystems
```bash
sudo mount $dev1"p1" /mnt
```
create an empty configuration
```bash
sudo nixos-generate-config --root /mnt
```
copy the files from github (overwrites empty configuration)
```bash
git clone -b pinetab2-minimal https://github.com/tromskusky/nixos
sudo cp nixos/*.nix /mnt/etc/nixos/ --verbose
```
edit configuration if you want
```bash
sudo nano /mnt/etc/nixos/configuration.nix
```
install the system
```bash
sudo nixos-install
```
if anything goes wrong then it is normally ok to google the problem and try again.

if the computer shuts down while installing you can mount the filesystem and install again, instead of repeating every step.

a backup of the configuration is found in /etc/nixos/backup after installation

the standard user is called guest with an empty password.
