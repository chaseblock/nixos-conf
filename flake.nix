{
  description = "Chase's Nix Flake for NixOS (Framework 13) and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixvim, ... }:
  {
    # A framework laptop
    nixosConfigurations.frame = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.framework-11th-gen-intel
        ./configuration/configuration.nix
        ./configuration/additional_laptop.nix
        ./hosts/frame-hardware-configuration.nix
        ./hosts/frame-host-configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.users.chase = {
            imports = [
              #nixvim.homeModules.nixvim
              ./home-manager/home.nix
              ./home-manager/linux.nix
            ];
          };
        }
      ];
    };

    # A Dell G7 laptop
    nixosConfigurations.g7 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # This is technically a different laptop, but maybe it will
        # work?
        #nixos-hardware.nixosModules.dell-g3-3779
        
        ./configuration/configuration.nix
        ./configuration/additional_laptop.nix
        ./hosts/g7-hardware-configuration.nix
        ./hosts/g7-host-configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.users.chase = {
            imports = [
              #nixvim.homeModules.nixvim
              ./home-manager/home.nix
              ./home-manager/linux.nix
            ];
          };
        }
      ];
    };

    # An Intel NUC, used as a homelab frontend
    # (not actually currently in use)
    nixosConfigurations.nym = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # This machine should actually be nuc-7i5bnh, but the config
        # below doesn't have anything that would differ between these
        # two models.
        nixos-hardware.nixosModules.intel-nuc-7i3bnb

        # Manual configurations
        ./configuration/configuration.nix
        ./hosts/nym-hardware-configuration.nix
        ./hosts/nym-host-configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.users.chase = {
            imports = [
              ./home-manager/home.nix
              ./home-manager/linux.nix
            ];
          };
        }
      ];
    };
  };
}
