{
  description = " Nuuvv's config flake ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, stylix,  ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."Nuuvv" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix 
          inputs.stylix.homeModules.stylix
        ];
      };
      nixosConfigurations = {
       "Nuuvv" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
          ./configuration.nix
          ];
        };
      };
    };
}
