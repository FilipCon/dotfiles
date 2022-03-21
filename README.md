## Installation instructions
GParted:
* Create partition table (efi/gpt for new systems, msdos/bios for old systems)
* Primary ext4 partition (bootable flags) -> Label to something useful like 'nixroot'
* (cond) EFI (200mb default) fat32 -> Label to 'nixboot'
* (opt) linux-swap (max 2gb) -> Label to 'swap' - maybe prefer .swapfile

After GParted, do:
* `sudo mount /dev/disk/by-label/nixroot /mnt`
* (cond) `sudo mkdir -p /mnt/boot` 
* (cond) `sudo mount /dev/disk/by-label/nixboot /mnt/boot'
* `sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152` create a 2gb swapfile
* `sudo chmod 600 /mnt/.swapfile`
* `sudo mkswap /mnt/.swapfile`
* `sudo swapon /mnt/.swapfile`

Generate configs located in `/mnt/etc/nixos/`:
* `sudo nixos-generate-config --root /mnt`

Install
* `sudo nixos-install`

**Remember to setup passwd afterwards**

## Common NixOS instructions

* `nix-channel --update`
* `sudo nixos-rebuild switch -I nixos-config=<path-to-congiguration-file>

## TODO
-[ ] Use `home-manager` for user configuration

- [ ] Fix `hardware-configuration.nix` file because I messed up during installation
 - Make fs by label and correct name (before installation)
 - Create swapfile device correctly (before installation)
