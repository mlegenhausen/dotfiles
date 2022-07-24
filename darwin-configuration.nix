{ config, lib, pkgs, ... }:

{
  environment.variables = { LANG = "en_US.UTF-8"; };

  # Add brew command line tools to the PATH.
  environment.systemPath = [ "/opt/homebrew/bin" ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ git vim wget ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; }) ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.gnupg.agent.enable = true;

  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = "0.2";
      mineffect = "scale";
      show-recents = false;
      tilesize = 64;

      wvous-br-corner = 4;
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      _FXShowPosixPathInTitle = true;
      QuitMenuItem = true;
    };

    LaunchServices = { LSQuarantine = false; };

    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
      PowerOffDisabledWhileLoggedIn = true;
      RestartDisabledWhileLoggedIn = true;
      ShutDownDisabledWhileLoggedIn = true;
      SHOWFULLNAME = true;
    };

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSScrollAnimationEnabled = false;
      NSTableViewDefaultSizeMode = 2;
      NSUseAnimatedFocusRing = false;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };

    SoftwareUpdate = { AutomaticallyInstallMacOSUpdates = true; };
  };

  # system.defaults.universalaccess.reduceTransparency = true;

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "uninstall";

    casks = [
      "bartender"
      "blackhole-2ch"
      "browserosaurus"
      "dropbox"
      "firefox-developer-edition"
      "fliqlo"
      "google-chrome-canary"
      "iterm2"
      "keepingyouawake"
      "licecap"
      "logitech-camera-settings"
      "logitech-firmwareupdatetool"
      "logitech-options"
      "microsoft-auto-update"
      "microsoft-office"
      "moneymoney"
      "onyx"
      "rectangle"
      "shadow-beta"
      "sidequest"
      "signal"
      "slack"
      "stats"
      "visual-studio-code"
      "visual-studio-code-insiders"
      "whatsapp"
      "vlc"
      "zoom"
    ];

    masApps = {
      "Amazon Prime Video" = 545519333;
      Bitwarden = 1352778147;
      "Next Meeting" = 1017470484;
      # "RollerCoaster Tycoon Classic" = 1113736426;
      "Unsplash Wallpapers" = 1284863847;
      "WireGuard" = 1451685025;
    };

    taps = [ "homebrew/cask" "homebrew/cask-drivers" "homebrew/cask-versions" ];
  };

  users.users.mlegenhausen = {
    name = "mlegenhausen";
    home = "/Users/mlegenhausen";
  };

  home-manager.users.mlegenhausen = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker-machine
      ffmpeg
      gnupg
      imagemagick
      jdk11
      jq
      lazygit
      neofetch
      nmap
      nodejs
      ocrmypdf
      pinentry_mac
      speedtest-cli
      yarn
      youtube-dl
    ];
    home.stateVersion = "22.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;
    };

    programs.git = {
      enable = true;
      userName = "Malte Legenahausen";
      userEmail = "mlegenhausen@mailbox.org";

      ignores = [ ".DS_Store" ".direnv" ];

      extraConfig = {
        core = { editor = "code-insiders --wait"; };
        github = { user = "mlegenhausen"; };
        push = { default = "simple"; };
      };

      includes = [{
        condition = "gitdir:~/dev/unsplash/";
        path = "~/dev/unsplash/.gitconfig-unsplash";
      }];

      signing = {
        key = "A32B9917F1ED507BC8FA920E5C41B60BF1F2E8C0";
        signByDefault = true;
      };
    };

    programs.gpg = { enable = true; };

    programs.zsh = {
      enable = true;
      zplug = {
        enable = true;
        plugins = [
          {
            name = "plugins/common-aliases";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/git";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/iterm2";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/macos";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/sudo";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/yarn";
            tags = [ "from:oh-my-zsh" ];
          }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-completions"; }
          { name = "zsh-users/zsh-history-substring-search"; }
          { name = "zsh-users/zsh-syntax-highlighting"; }
          {
            name = "romkatv/powerlevel10k";
            tags = [ "as:theme" "depth:1" ];
          }
        ];
      };
      plugins = [{
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }];
      shellAliases = { code = "code-insiders"; };
    };
  };
}
