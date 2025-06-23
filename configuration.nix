{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./Modules/hardware-configuration.nix
      ./Modules/packages.nix
      inputs.home-manager.nixosModules.home-manager
      ./Modules/Syncthing.nix
    ];

   nix.settings.auto-optimise-store = true;
   nix.gc = { 
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 10d";
   };

  # Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      Nuuvv = import ./Modules/home-manager/home.nix;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Nuuvv-Nix"; # Define your hostname.

  #Network Manager
  networking.networkmanager.enable = true;

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
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
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
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable sound.
    services.pipewire = {
      enable = true;
      pulse.enable =true;
    };

  # Define a user account
   users.users.Nuuvv = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
  
  nixpkgs.config.allowUnfree = true;

  # Steam
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; #open ports for remote play
     dedicatedServer.openFirewall = true; #open ports for source deidacated server
     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network game transfers
   };

   hardware.steam-hardware.enable = true;
   hardware.xone.enable = true;

  # Fonts
   fonts.packages = with pkgs; [
     nerd-fonts.noto
     font-awesome
     powerline-fonts
     powerline-symbols
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
     nerd-fonts.jetbrains-mono
     material-design-icons
   ];

  # Portals screensharing and other interactions
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # Open ports in the firewall.
    # Syncthing ports: 8384 for remote access to GUI
   networking.firewall.allowedTCPPorts = [ 8384 22000 ];
   networking.firewall.allowedUDPPorts = [ 22000 21027 ];
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

