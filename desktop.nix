{ config, pkgs, ... }:

{
  imports =
    [ 
      ./core.nix
    ];

  # Add sound kernel modules
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
    
  # CUPS
  # TODO: Move to a module
  services.printing.enable = true;

  hardware = {
    # Turn on BlueTooth support
    # TODO: Move to module file
    bluetooth.enable = true;

    # Allow hardware accelerated drivers to run in 31-bit mode
    opengl.driSupport32Bit = true;

    # Enable PulseAudio with JACK integration
    # TODO: Follow these instructions - https://nixos.org/wiki/Audio_HOWTO
    pulseaudio = {
      enable = true;
      #package = pkgs.pulseaudio.override { jackaudioSupport = true; };
    };
  };

  # Configure X11
  services.xserver = {
    # Enable X, configure drivers
    enable = true;
    autorun = false;
    layout = "us";

    # Disable xterm and XFCE, enable StumpWM
    # TODO: Move this to module file
    desktopManager.default = "none";
    windowManager.default = "stumpwm";
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = false;
    windowManager.stumpwm.enable = true;
  };

  # Configure fonts
  # TODO: Move to module file
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      ubuntu_font_family
      anonymousPro
      dejavu_fonts
      liberation_ttf
      proggyfonts
      source-sans-pro
      terminus_font
      ttf_bitstream_vera
    ];
  };

  # Not exactly sure what this accomplishes, from wiki advice...
  security.setuidPrograms = [
    "xlaunch"
  ];

  environment.systemPackages = with pkgs; [
    # Window Management
    stumpwm
    compton
    xlaunch
    #bumblebee # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/X11/bumblebee/default.nix

    # Audio / Media Players
    smplayer
    vlc
    mpd
    ardour
    supercollider
    ncmpcpp
    qjackctl
    pavucontrol

    # Games
    steam

    # Web
    chromium
    
    # Photos and Graphics
    xfce.ristretto   # Doesn't come with PNG support.  Fix it?  Use something else instead?
    darktable
    gimp
    inkscape
    processing

    # Video
    #makemkv # NOTE: Didn't build...
    #cinelerra # NOTE: Package points to outdate Git repo url, doesn't build
    mpv
    handbrake

    # Desktop Tools
    dmenu
    i3lock
    xfce.xfce4_power_manager
    xfce.xfce4terminal
    spideroak
    #smbclient # Not found, find correct package
    blueman 
    scrot
    p7zip
    gnupg
    filezilla
    fbpanel

    # Haskell packages
    (haskellPackages.ghcWithPackages (self : [
      haskellPlatform
      self.taffybar
      self.gitAnnex
    ]))
  ];
}
