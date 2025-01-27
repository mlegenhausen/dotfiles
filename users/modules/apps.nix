{ pkgs, lib, config, options, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ git rsync vim wget ];

  # Add brew command line tools to the PATH.
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    brews = [
      "graphite"
      "heroku"
      "ocr"
    ];

    casks = [
      "appcleaner"
      "arc"
      "balenaetcher"
      "blackhole-2ch"
      "browserosaurus"
      "discord"
      "docker"
      "dropbox"
      "figma"
      "firefox@developer-edition"
      "fliqlo"
      "freetube"
      "fujitsu-scansnap-home"
      "google-chrome"
      "iterm2"
      "keepingyouawake"
      "libreoffice"
      "licecap"
      "logi-options+"
      "logitech-camera-settings"
      "logitech-firmwareupdatetool"
      "loom"
      "lulu"
      "minecraft"
      "moneymoney"
      "onyx"
      "rectangle"
      "sidequest"
      "signal"
      "slack"
      "stats"
      "steam"
      "tiptoi-manager"
      "teamviewer"
      "utm"
      "visual-studio-code"
      "visual-studio-code@insiders"
      "whatsapp@beta"
      "vlc"
      "zoom"
    ];

    # masApps = {
    #   "Amazon Prime Video" = 545519333;
    #   Bitwarden = 1352778147;
    #   "Home Assistent" = 1099568401;
    #   "Next Meeting" = 1017470484;
    #   # "RollerCoaster Tycoon Classic" = 1113736426;
    #   "Unsplash Wallpapers" = 1284863847;
    #   "WireGuard" = 1451685025;
    # };

    taps = [ "heroku/brew" "homebrew/cask-versions" "schappim/ocr" "withgraphite/tap" ];
  };
}
