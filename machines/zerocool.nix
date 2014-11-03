{ config, pkgs, ... }:

{
  imports =
    [ 
      ./macbook-common.nix
    ];

  # Configure networking
  networking = {
    # Set the hostname
    hostName = "zerocool"; 
  };

  # Configure X11
  services.xserver = {
    # Configure drivers
    videoDrivers = ["nouveau" "intel"];
  };

  environment.systemPackages = with pkgs; [
    linuxPackages_3_16.nvidiabl
  ];
}
