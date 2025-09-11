{ config, pkgs, pkgs-unstable, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		./local-configuration.nix
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.loader.systemd-boot.configurationLimit = 5;
	boot.loader.systemd-boot.memtest86.enable = true;

	hardware.graphics.enable = true;

	# Networking
	networking.networkmanager.enable = true;
	networking.firewall.enable = false;
	networking.firewall.allowedTCPPorts = [ ];
	networking.firewall.allowedUDPPorts = [ ];

	hardware.bluetooth.enable = true; 

	# Locality stuff 
	time.timeZone = "Europe/Copenhagen";
	i18n.defaultLocale = "da_DK.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "da_DK.UTF-8";
		LC_IDENTIFICATION = "da_DK.UTF-8";
		LC_MEASUREMENT = "da_DK.UTF-8";
		LC_MONETARY = "da_DK.UTF-8";
		LC_NAME = "da_DK.UTF-8";
		LC_NUMERIC = "da_DK.UTF-8";
		LC_PAPER = "da_DK.UTF-8";
		LC_TELEPHONE = "da_DK.UTF-8";
		LC_TIME = "da_DK.UTF-8";
	};
	console.keyMap = "dk-latin1";


	# Users
	programs.fish.enable = true;
	users.users.chr = {
		isNormalUser = true;
		description = "Christian Surlykke";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
		packages = with pkgs; [];
	};
	services.getty.autologinUser = "chr";

	# Packages and services
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		memtest86plus
		bluez
	];
	services.openssh.enable = true;
	security.polkit.enable = true;

	security.rtkit.enable = true;
  		services.pipewire = {
		enable = true; # if not already enabled
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# From whence we came
	system.stateVersion = "25.05"; # Don't change

	
	nix.settings.experimental-features = ["nix-command" "flakes"];
}
