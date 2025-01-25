# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "oslo"; # Define your hostname.                                  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
                                                                                         # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";
                                                                                         # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";                                                            LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";                                                           LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.                       services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";                                                                         variant = "";
  };
  # Enable CUPS to print documents.                                                      services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;                                                          services.pipewire = {
    enable = true;                                                                         alsa.enable = true;
    alsa.support32Bit = true;                                                              pulse.enable = true;
    # If you want to use JACK applications, uncomment this                                 #jack.enable = true;
                                                                                           # use the example session manager (no others are packaged yet so this is enabled by default,                                                                                  # no need to redefine it in your config for now)
    #media-session.enable = true;                                                        };                                                                                                                                                                            # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.                 users.users.admodevops = {
    isNormalUser = true;                                                                   description = "Adolfo Moyano";                                                         extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];                         packages = with pkgs; [
      kdePackages.kate                                                                     #  thunderbird
    ];                                                                                     shell = pkgs.bash;
  };

  # Install firefox.
  programs.firefox.enable = true;
  # Allow unfree packages                                                                nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # For packages with versions, like installing go 1.22 I personally use the explicit version on my user packages section, like this: go_1_22, so I can change versions seamlessly
  home-manager.users.admodevops = { pkgs, ... }: {                                         home.packages = with pkgs; [
        home-manager
        ripgrep                                                                                fd
        bat
        eza
        zig
        ghostty
        emacs
        sbcl
        clojure
        leiningen
        julia
        elixir
        erlang                                                                                 nodejs_22
        go_1_22                                                                            ];
                                                                                           home.stateVersion = "25.05";
  };
  environment.systemPackages = with pkgs; [                                                bash
    bash-completion                                                                        curl
    wget
    gcc
    openjdk21
    python3
    rustc
    cargo
    ruby
    php
    vscode
    sublime3
    gnumake
    cmake
    docker
    docker-compose
  ];

  # Development environment packages configuration
  virtualisation.docker.enable = true;
  programs.git.enable = true;
  programs.bash = {
    enableCompletion = true;
  };
  environment.shellInit = ''
    # Add system-wide shell initialization here
  '';
  environment.interactiveShellInit = ''
    if [ ! -d "$HOME/.oh-my-bash" ]; then
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    fi
  '';
  environment.shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    update-system = "sudo nixos-rebuild switch";
    update = "sudo nix-channel --update";
    delete-garbage = "sudo nix-collect-garbage -d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
