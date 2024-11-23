{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  config = {
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "rtl8821ce"];
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
    boot.blacklistedKernelModules = [ "rtw88_8821ce" ];
    boot.extraModprobeConfig = ''
    blacklist rtw88_8821ce
  '';

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/9fc4d123-7e23-4244-b770-dd042837f6cc";
        fsType = "ext4";
      };

    boot.initrd.luks.devices."luks-81e34e5b-40fa-4717-bd33-17625917c36d".device = "/dev/disk/by-uuid/81e34e5b-40fa-4717-bd33-17625917c36d";

    fileSystems."/boot/efi" =
      { device = "/dev/disk/by-uuid/E322-2869";
        fsType = "vfat";
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/3954101b-9ab3-4b3e-9f7c-628ccf3e5c2c"; }
      ];

    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Setup keyfile
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    # Enable swap on luks
    boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".device = "/dev/disk/by-uuid/f9a78d3d-284b-45f5-a4d7-27ffab4b2f79";
    boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".keyFile = "/crypto_keyfile.bin";

    networking.hostName = "nixos"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput = {
      enable = true;
      touchpad.tapping = true;
      touchpad.naturalScrolling = false;
      touchpad.disableWhileTyping = true;
    };

  };
}
