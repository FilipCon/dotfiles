{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "firewire_ohci"
                                         "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "wl" ];
  boot.kernelPackages = pkgs.linuxPackages_5_4;
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # gpu drivers
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;

  fileSystems."/" =
    { device = "/dev/disk/by-label/msdos";
      fsType = "ext4";
    };

  swapDevices = [
  {
    device = "/dev/disk/by-label/swap";
  }
 ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
