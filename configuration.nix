{ config, pkgs, ... }:

let 
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
	imports = [ 
		./hardware-configuration.nix
		./local-configuration.nix
		(import "${home-manager}/nixos")
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

	 environment.systemPackages = 
        	with pkgs; [
				home-manager  
				#alacritty
				blueman
				curl
				feh
				flameshot
				git
				#git-delta
				gtklock
				htop
#				openfortivpn
				jdk21
				#openjdk-17-source
				pavucontrol
				playerctl
				ripgrep
				unclutter
				waybar
				xdg-desktop-portal
				xdg-desktop-portal-wlr
#				lxpolkit
#				lxappearance
				bridge-utils
				#cpu-checker
				#libvirt-clients
				#libvirt-daemon
				#libvirt-daemon-system
				#virtinst
				#virt-manager
				#qemu-system
				#qemu-kvm
				#firewall-config
				#firewalld
				#clamav-freshclam
				#clamav-daemon
				#net-tools
				gcc
				dmenu
				i3status
				xdg-user-dirs
			    shared-mime-info
				zip
				unzip
				fish
				neovim
				brave
				google-chrome
				cowsay
				bash
				pysolfc
				imagemagick.dev
				networkmanagerapplet
				slack
				dmidecode
				direnv
				nix-direnv
					#		pkg-config
				lazygit
				libnotify
				dunst
				pciutils
				usbutils
				killall
				adwaita-icon-theme
				numix-icon-theme-circle
				speedcrunch
				jq
				nix-index
#				dbvisualizer
			];
	

	home-manager.users.chr = {config, pkgs, ...} :
		{
		home.stateVersion = "18.09";
		home.packages = [
			(pkgs.callPackage /home/chr/projekter/refude/package.nix { })	
			(pkgs.callPackage /home/chr/projekter/utils/package.nix { })	
		];
		home.file = {
			".config/alacritty" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/alacritty";
			};
			".config/fish" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/fish";
			};
			".config/gtk-3.0" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/gtk-3.0";
			};
			".config/i3status" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/i3status";
			};
			".config/lazygit" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/lazygit";
			};
			".config/mimeapps.list" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/mimeapps.list";
			};
			".config/nvim" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/nvim";
			};
			".config/sway" = {
			    source = config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/config/sway";
			};
#			".local/bin" = {
#			    source =  config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/.local/bin";
#			};
#			".local/share/applications" = {
#			    source =  config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/.local/share/applications";
#			};
		};
	};


	# From whence we came
	system.stateVersion = "25.05"; # Don't change
	
}
