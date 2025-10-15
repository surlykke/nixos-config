{ config, pkgs, pkgs-unstable, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		./local-configuration.nix
	];

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

	hardware = {
		graphics.enable = true;
		bluetooth = {
			enable = true; 
		};
	};

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		loader.systemd-boot = {
			configurationLimit = 5;
			memtest86.enable = true;
		};
	};

	# Networking
	networking = {
		networkmanager.enable = true;
		firewall = {
			enable = false;
			allowedTCPPorts = [ ];
			allowedUDPPorts = [ ];
		};
	};

	# Packages and services
	nixpkgs.config.allowUnfree = true;

	programs = {
		fish.enable = true;
		sway = {
			enable = true;
			wrapperFeatures.gtk = true; # so that gtk works properly
			extraPackages = with pkgs; [
				swaylock
				swayidle
				wl-clipboard
				mako # notification daemon
				alacritty # terminal
			];
		};	
		xwayland.enable = true;
	};

	services = {
		getty.autologinUser = "chr";


		avahi = {
		  enable = true;
		  nssmdns4 = true;
		  openFirewall = true;
		};

		printing = {
		  enable = true;
		  drivers = with pkgs; [
			cups-filters
			cups-browsed
		  ];
		};

		pipewire = {
			enable = true; # if not already enabled
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		upower.enable = true;

		openssh.enable = true;
	};	

	security = {
		polkit.enable = true;

		rtkit.enable = true;
	};

	users = {
			users.chr = {
			isNormalUser = true;
			description = "Christian Surlykke";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.fish;
			packages = with pkgs; [];
		};
	};

	# From whence we came
	system.stateVersion = "25.05"; # Don't change
	
	nix.settings.experimental-features = ["nix-command" "flakes"];
}
