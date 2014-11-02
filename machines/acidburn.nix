{ config, pkgs, ... }:

{
  imports =
    [ 
      ./macbook-common.nix
    ];

  # Configure networking
  networking = {
    # Set the hostname
    hostName = "acidburn"; 
  };

  # Configure X11
  services.xserver = {
    # Configure drivers
    videoDrivers = ["intel"];
  };
}
