# Theo's NixOS Install

## Create the Installation USB

Use the minimal ISO image from: https://nixos.org/download/

```sh
sudo gdisk /dev/sda

# 1. `o` to create a new GPT
# 2. `w` to write to the disk

# verify no partition exists
lsblk -f

sudo dd if=$ISO_PATH of=/dev/sda bs=1M status=progress
```

## Boot & WiFi

- Turn the sEcUrE bOoT off

```sh
sudo su
nmcli device wifi | less
nmcli device wifi connect "$SSID" --ask
```

## Format & Partition

```sh
# get the name of the disk
lsblk
# or /dev/sda1
DISK=/dev/nvme0n1

gdisk $DISK
# 1. `p` to print all existing partition
# 2. `o` to create a new GPT
# 3. `w` to write to the disk
# alternatively:
# 1. `d` -> `1` to delete partion 1
# 2. Repeat for all partitions
# 3. `w` to write to the disk

gdisk $DISK
# 1. `n` to make a new partition (boot EFI)
#    ``
#    Partition Number: 1
#    First Sector: <RET> (beginning of the sector)
#    Last Sector: +1G
#    Hex code or GUID: ef00
#    ``
# 2. `n` to make a new partition (LVM root)
#    ``
#    Partition Number: 2
#    First Sector: <RET>
#    Last Sector: <RET> (rest of the disk)
#    Hex code or GUID: 8e00
#    ``
# 3. `w` to write and exit

# Verify that /dev/nvme0n1p1 and /dev/nvme0n1p2 exist and is of right format
lsblk -f
```

## LUKS

```sh
LVM_PART=/dev/nvme0n1p2
cryptsetup luksFormat -v --label=NIXOS_LUKS $LVM_PART

cryptsetup luksOpen $LVM_PART cryptroot
# Make sure it exists
ls /dev/mapper/cryptroot
```

## LVM Partitioning

```sh
CRYPTROOT=/dev/mapper/cryptroot

# Physical volume & volume group
pvcreate $CRYPTROOT
GROUP_NAME=lvmroot
vgcreate $GROUP_NAME $CRYPTROOT

# Logical volumes
RAM_SZ=32G
lvcreate --size    $RAM_SZ   --name swap $GROUP_NAME
lvcreate --extents 100%FREE  --name root $GROUP_NAME
```

## Filesys

```sh
BOOT_PART=/dev/nvme0n1p1
mkfs.vfat -n NIXOS_BOOT $BOOT_PART

mkfs.ext4 -L NIXOS_ROOT /dev/mapper/lvmroot-root
mkswap    -L NIXOS_SWAP /dev/mapper/lvmroot-swap
```

## Mounting

```sh
mount /dev/disk/by-label/NIXOS_ROOT /mnt

mkdir /mnt/boot
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot

swapon -L NIXOS_SWAP

lsblk -o name,type,mountpoints $DISK
# Make sure it looks like
# nvme0n1                       disk
#   |- nvme0n1p1                part    /mnt/boot
#   |- nvme0n1p2                part
#       |- cryptroot            crypt
#           |- lvmroot-swap     lvm     [SWAP]
#           |- lvmroot-root     lvm     /mnt
```

## Modifying `hardware-configuration.nix`

```sh
nixos-generate-config --root /mnt
```

In `/mnt/etc/nixos/hardware-configuration.nix`:

```nix
{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
    # ...

    # add `cryptd` to kernelModules
    boot.initrd.kernelModules = [ "dm-snapshot" "cryptd" ];  # cryptd manually added
    # !!!!! IMPORTANT: add the following line
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";  # manually added

    fileSystems."/" =
      { device = "/dev/disk/by-label/NIXOS_ROOT";  # changed from /dev/mapper/lvmroot-root
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-label/NIXOS_BOOT";    # changed from /dev/disk/by-uuid/hash-uuid
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-label/NIXOS_SWAP"; }   # changed from /dev/mapper/lvmroot-swap
      ];

    # ...
    hardware.enableAllFirmware = true;  # manually added
```


## Option 1: Using the Flake in This Repository to Install NixOS

```sh
git clone https://github.com/theopn/nix-conf ~/nix-conf
cd ~/nix-conf

cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/wittgenstein/hardware-configuration-2.nix
# ! IMPORTANT: Use Vim's diff tool to make sure LUKS device is set up the same way as the reference before replacing it
# LUKS setup is crucial otherwise it will not boot.
mv ./hosts/wittgenstein/hardware-configuration-2.nix ./hosts/wittgenstein/hardware-configuration.nix
# also change name of the hardware module in `flake.nix`

# install NixOS
nixos-install --flake .#wittgenstein
# set root password
reboot

# login as root and then run `passwd`
passwd theopn
```

## Option 2: Creating a new Flake and Install NixOS

Create a sample `flake.nix` in the `/mnt/etc/nixos` directory:

```sh
{
	description = "Theo's Initial NixOS Flake";
	inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
	outputs = inputs@{ self, nixpkgs, ... }:
	{
		nixosConfigurations.myhostname = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./configuration.nix ];
		};
	};
}

```

Go to `configuration.nix` and do the following:

- Add following (`unFree` is generally needed for hardware drivers)
    ```nix
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ```
- Set `hostname`
- Configure user(s)
- Enable networking
- (optional) add display manager and DE/WM

```sh
nixos-install --flake .#myhostname
# set root password
reboot

# login as root and then run `passwd`
passwd theopn
```

