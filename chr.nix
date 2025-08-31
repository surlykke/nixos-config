{ config, lib, pkgs, pkgs-unstable, ... }:

{
    home.username = "chr";
    home.homeDirectory = "/home/chr";

  # Packages that should be installed to the user profile.
    home.packages = 
	(with pkgs; [
        alacritty
        blueman
        curl
        feh
        flameshot
        git
        #git-delta
        go
        gopls
        gtklock
        htop
        #openfortivpn
        jdk21
        #openjdk-17-source
        pavucontrol
        playerctl
        ripgrep
        sway
        swaylock
        swayidle
        unclutter
        xdg-desktop-portal
        xdg-desktop-portal-wlr
            #lxpolkit
        #lxappearance
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
        zip
        unzip
        adwaita-icon-theme
        fish
        neovim
	])

	++
	(with pkgs-unstable; [
		dbvisualizer
	]);

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
        ".local/bin" = {
            source =  config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/.local/bin";
        };
        ".local/share/applications" = {
            source =  config.lib.file.mkOutOfStoreSymlink "/home/chr/nixos/home/.local/share/applications";
        };
    };


    home.stateVersion = "25.05";
}
