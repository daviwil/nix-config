{ config, pkgs, ... }:

{
  imports =
    [ 
      # Remove if unneeded.
    ];

  # NOTE: Example configs
  # - https://github.com/chaoflow/nixos-configurations/blob/master/configuration-eve.nix
  # - https://github.com/lfont/dotfiles/blob/master/nixos/configuration.nix

  # Set the timezone
  time.timeZone = "America/Los_Angeles";

  # Make the manual available on F8 terminal
  services.nixosManual.showManual = true;

  # Configure boot parameters
  boot = {
    # Set kernel version and load kernel modules
    # TODO: Move to module file
    kernelPackages = pkgs.linuxPackages_3_16;
  };

  # Configure networking
  networking = {
    # Configure the firewall
    firewall.enable = true;
    firewall.allowPing = true;

    # Turn on wifi and use NetworkManager instead of wpa_supplicant
    # TODO: Move to module file
    wireless.enable = false;
    networkmanager.enable = true;
  };

  # Configure locale
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # OpenSSH
  services.openssh.enable = true;

  # Configure MPD
  # TODO: Move to module file
  services.mpd = {
    enable = true;
    dataDir = "/home/mpd";
    musicDirectory = "/home/mpd/Music";
  };

  # Enable upower
  services.upower.enable = true;

  # Set screensaver on returning from suspend
  # TODO: Set up i3lock?
  powerManagement.resumeCommands = "";
  
  # Configure acpid
  #services.acpid = {
  #  # TODO: See https://github.com/NixOS/nixos/blob/master/modules/services/hardware/acpid.nix
  #};

  # Create a user account
  users.extraUsers.daviwil = {
    name = "daviwil";
    description = "David Wilson";
    group = "users";
    extraGroups = [ "wheel" "audio" "networkmanager" ];
    uid = 1000;
    createHome = true;
    home = "/home/daviwil";
    shell = "/run/current-system/sw/bin/bash";
  };

  # Configure packages (may cause source build)
  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;

    #chromium.enablePepperPDF = true;
    #chromium.hiDPISupport = true;
  };

  # Configure Samba
  # TODO: Move to module file
  # TODO: https://nixos.org/wiki/Samba_on_nix

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Development Tools
    git
    emacs
    vim
    
    # Clojure
    leiningen
    
    # Networking
    networkmanager_openvpn

    # Virtualization
    #virtualbox
    docker
  ];
}
