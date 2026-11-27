{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./Modules/hardware-configuration.nix
      ./Modules/packages.nix
     # inputs.home-manager.nixosModules.home-manager
      ./Modules/Syncthing.nix
      #./Modules/VM.nix
      #./Modules/Gpu-passthrough.nix
      ./Modules/ssh-host.nix
      ./Modules/VPN.nix
      ./Modules/extra-rules.nix
      ./Modules/kopia.nix
      ./Modules/cursor.nix
    ];

  #Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Nix store optimizations and Garbage collection
  nix.settings.auto-optimise-store = true;
  nix.gc = { 
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
 
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Nh environment variable
  environment.sessionVariables = {
    NH_FLAKE = "/home/Nuuvv/.config/Nixos";
  };

  # Battery
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  #start SSH agent
  programs.ssh.startAgent = true;

  #G502 mapping
  services.ratbagd.enable = true;

  # Home-manager
 # home-manager = {
 #   useGlobalPkgs = true;
 #   useUserPackages = true;
 #   extraSpecialArgs = { inherit inputs; };
 #   users = {
 #     Nuuvv = import ./Modules/home-manager/home.nix;
 #   };
 # };

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  # Use GRUB to boot like a real MAN
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  networking.hostName = "LL-Nix"; # Define your hostname.

  #Network Manager
  networking.networkmanager.enable = true;

  #Player controller
  services.playerctld.enable = true;

  # Timezone
  time.timeZone = "America/Buenos_Aires";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
   };

  # Enabling hyprland and Wayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
     };
 environment.sessionVariables = {
    #if cursor becomes invisible
   WLR_NO_HARDWARE_CURSORS = "1";
    #hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
  #enable Opengl 
  hardware.graphics = {
    enable = true;
  };
    # Load nvidia driver for Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
      # Modesetting is reqquired.
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
      #    enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

  # Enable sound.
    services.pipewire = {
      enable = true;
      pulse.enable =true;
      alsa.enable = true;
    };

  # Define a user account
   users.users.Nuuvv = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
  
  nixpkgs.config.allowUnfree = true;

  # Steam
   programs = {
     steam = {
       enable = true;
       remotePlay.openFirewall = true; #open ports for remote play
       dedicatedServer.openFirewall = true; #open ports for source deidacated server
       localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network game transfers
     };
   };

   hardware.steam-hardware.enable = true;

   xdg.portal = {
     enable = true;
     extraPortals = with pkgs; [xdg-desktop-portal-gtk];
     config = {
       common.default = ["gtk"];
     };
   };

  # Fonts
   fonts.packages = with pkgs; [
     nerd-fonts.noto
     font-awesome
     powerline-fonts
     powerline-symbols
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-color-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
     nerd-fonts.jetbrains-mono
     material-design-icons
   ];

  # Open ports in the firewall.
    # Syncthing ports: 8384 for remote access to GUI
   networking.firewall.allowedTCPPorts = [ 8384 22000 ];
   networking.firewall.allowedUDPPorts = [ 22000 21027 ];
   networking.firewall.trustedInterfaces = [ "virbr0" "virtio" ];
  # networking.firewall.allowedTCPPorts = [ ... ];

  # Flakey boi
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Don't delete or change

  system.stateVersion = "25.05"; 

}

