{ 
    description = "Basis flake"; 

    inputs = { 
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; 
        home-manager = { 
            url = "github:nix-community/home-manager/release-25.05"; 
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager 
				{ 
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.chr = import ./chr.nix;
                }
            ];
        };
    };
}
