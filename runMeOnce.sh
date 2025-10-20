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

if ls $HOME/projekter/refude >/dev/null 2>/dev/null; then
	echo $HOME/projekter/refude is in the way. Please move it.
fi 

if ls $HOME/projekter/windowarranger >/dev/null 2>/dev/null; then
	echo $HOME/projekter/windowarranger is in the way. Please move it.
fi 

mkdir -p $HOME/projekter

pushd $HOME/projekter

git clone https://github.com/surlykke/refude
git clone https://github.com/surlykke/windowarranger

popd 

cat <<-EOF
	Setup done.
	You can now run:

		sudo nixos-rebuild switch -I nixos-config=$(pwd)/configuration.nix

	/etc/nixos left in place, but should not be used
EOF
