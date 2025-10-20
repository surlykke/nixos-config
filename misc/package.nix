{ stdenv } : 
stdenv.mkDerivation {
	pname = "utils";
	version = "0.1";
	src = ./.;
	installPhase =
	''  
		mkdir -p $out/bin
		mkdir -p $out/share
		cp -R bin/* $out/bin
		cp -R share/* $out/share
	'';
}
#let
#  pkgs = import <nixpkgs> {};
#in
#	pkgs.stdenv.mkDerivation {
#		pname = "refude";
#		version = "0.1";
#		src = ./.;
#		buildInputs = with pkgs; [
#			go
#			gtk4
#			gtk4-layer-shell
#		];
#
#		preConfigure = ''
#			export GOCACHE=$TMPDIR/go-cache
#			export GOMODCACHE=$TMPDIR/gomod-cache
#		'';
#
#		buildPhase =
#		''
#			go build ./cmd/refude-server
#			go build ./cmd/refuc
#			go build ./cmd/refude-nm
#		'';
#
#		installPhase =
#		''
#			echo "Installing at $out/bin"
#			mkdir -p $out/bin
#			mv refude-server refuc refude-nm $out/bin
#		'';
#
#	}
