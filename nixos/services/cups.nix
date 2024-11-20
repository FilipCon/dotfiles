{ config, pkgs, lib, ... }:

{
  config = {
    # Enable CUPS to print documents.
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.samsung-unified-linux-driver ];
    hardware.printers = {
      ensurePrinters = [
        {
          name = "Samsung_M2020";
          location = "Home";
          deviceUri = "usb://Samsung/M2020%20Series?serial=08HVB8GJ7F04Q2D";
          model = "samsung/M262x.ppd";
          ppdOptions = {
            PageSize = "A4";
          };
        }
      ];
    };

  };
}
