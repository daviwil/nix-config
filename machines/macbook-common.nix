{ config, pkgs, ... }:

{
  imports =
    [ 
      ../desktop.nix
    ];

  # Configure boot parameters
  boot = {
    # Tweak kernel settings
    # TODO: Is this needed when NVIDIA is disabled?
    #kernel.sysctl."i915.invert_brightness" = 1;
    
    # TODO: Is this needed?  Gets added automatically?
    #boot.kernelModules = [ "bbswitch" ];

    # Use the gummiboot efi boot loader.
    loader.gummiboot.enable = true;
    loader.gummiboot.timeout = 8;
    loader.efi.canTouchEfiVariables = true;
  };

  # Hardware settings
  hardware = {
    # Disable NVIDIA adapter until needed
    # - Run discrete_vga_poweron to turn it back on
    # TODO: Experiment with this
    #nvidiaOptimus.disable = true;
  };

  # Configure X11
  services.xserver = {
    # Set up touchpad
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.horizontalScroll = true;
    synaptics.palmDetect = true;
    synaptics.tapButtons = true;
    synaptics.buttonsMap = [ 1 3 2 ];  # Mouse button 3 is two-finger tap by default...

    # Enable video acceleration
    vaapiDrivers = [ pkgs.vaapiIntel ];
  };

  # Enable pommed to deal with MacBook hotkeys
  # TODO Why does this fail?
  #services.hardware.pommed.enable = true;
}
