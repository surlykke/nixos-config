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

sudo mv /etc/nixos /etc/nixos-backup-of-initial

cat <<-EOF
	Setup done.
	You can now run:

		sudo nixos-rebuild switch -I nixos-config=$(pwd)/configuration.nix
EOF
