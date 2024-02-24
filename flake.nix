{
  description = "HyprNix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    nix-colors.url = "github:misterio77/nix-colors";

    #firefox-addons = {
    #  url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };  

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/default/configuration.nix

            inputs.home-manager.nixosModules.default
	    inputs.disko.nixosModules.default
            inputs.impermanence.nixosModules.impermanence

	    (import ./disko.nix { device = "/dev/nvme0n1"; })
          ];
        };

        test = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
          ];
        };

      };
    };
}
