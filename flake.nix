{
  description = "Chase's Nix Flake for NixOS (Framework 13) and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixvim, ... }:
  {
    nixosConfigurations.frame = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        #nixos-hardware.nixosModules.framework-amd-ai-300-series
        nixos-hardware.nixosModules.framework-11th-gen-intel
        ./hosts/frame/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.users.chase = {
            imports =[
              nixvim.homeModules.nixvim
              ./home-manager/home.nix
              ./home-manager/linux.nix
            ];
          };
        }
      ];
    };
  };
}
