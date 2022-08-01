{ pkgs, lib, config, options, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ git vim wget ];

  # Add brew command line tools to the PATH.
  environment.systemPath = [ "/opt/homebrew/bin" ];

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
}