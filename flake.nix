{ 
    description = "Basis flake"; 

    inputs = { 
        nixpkgs.url = "nixpkgs/nixos-25.05"; 
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.05"; 
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager,... }@inputs: 
		let 
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
			#	pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
			pkgs-unstable = import nixpkgs-unstable {
				system = system;
				config = {
					allowUnfree = true;
				};
			};
			username = "chr";
		in {
			nixosConfigurations = {
				nixos = lib.nixosSystem {
					specialArgs = {
						inherit system;
						inherit pkgs-unstable;
					};
					modules = [ 
						./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.extraSpecialArgs = {
								inherit pkgs-unstable;
							};
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.chr = import ./chr.nix;
						}	
					];
				};
			};
		};
}

