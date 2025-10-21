#!/usr/bin/env bash

thisdir=$(realpath $(dirname $0))
cd $thisdir


cp /etc/nixos/hardware-configuration.nix .

cat <<-EOF > ./local-configuration.nix
{ config, pkgs, ... } : 

{
$(grep boot.loader /etc/nixos/configuration.nix)
  networking.hostName = "nixos";
}
EOF

cat <<-EOF > local-projects.nix
	{ config, pkgs, ... }:
	{
		home.packages = [
	#	(pkgs.callPackage /path/to/my-project/package.nix { })
		];
	}
EOF



cat <<-EOF
	Setup done.
	You can now run:

		sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable pkgs-unstable

	and then:

		sudo nixos-rebuild switch -I nixos-config=$(pwd)/configuration.nix

	/etc/nixos left in place, but should not be used
EOF
