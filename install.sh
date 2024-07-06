#!/bin/sh
dev1=/dev/mmcblk1

yn () {
  read -p "This will wipe $dev1 ! Continue (y/n)?" choice
  case "$choice" in
    y|Y ) echo "yes";;
    n|N ) exit;;
    * ) yn;;
  esac
}
yn
echo this script requires sudo, nix-shell and nixos-install-tools to be installed
sudo echo sudo installed :)

tmpbt=$(mktemp -d)
tmpgit=$(mktemp -d)

sudo parted $dev1 -- mklabel gpt
sudo parted $dev1 -- mkpart ESP fat32 18MB 1GB
sudo parted $dev1 -- set 1 esp on
sudo parted $dev1 -- mkpart root btrfs 1GB 100%
sudo mkfs.fat -F 32 $dev1"p1"
sudo mkfs.btrfs $dev1"p2"
sudo mount $dev1"p2" $tmpbt
sudo btrfs subvolume create $tmpfbt/@nix
sudo btrfs subvolume create $tmpfbt/@home
sudo umount $tmpbt
sudo mount -t tmpfs tmpfs /mnt
sudo mkdir -p /mnt/boot /mnt/nix /mnt/home/user1
sudo mount $dev1"p1" /mnt/boot
sudo mount $dev1"p2" -o subvol=@nix /mnt/nix
sudo mount $dev1"p2" -o subvol=@home /mnt/home
cd $tmpgit
nix-shell -p git --run "git clone -b pinetab2-minimal https://github.com/tromshusky/nixos"
cd nixos
sudo nixos-generate-config --root /mnt
cp /mnt/etc/nixos/* .
sudo nixos-install --flake .#nixos
