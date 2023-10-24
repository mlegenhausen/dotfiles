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
      "heroku"
      "ocr"
    ];

    casks = [
      "altserver"
      "appcleaner"
      "bartender"
      "betterdisplay"
      "blackhole-2ch"
      "browserosaurus"
      "cider"
      "coconutbattery"
      "deepl"
      "digikam"
      "discord"
      "docker"
      "dropbox"
      "firefox-developer-edition"
      "fliqlo"
      "google-chrome"
      "google-chrome-canary"
      "iterm2"
      "keepingyouawake"
      "licecap"
      "logi-options-plus"
      "logitech-camera-settings"
      "logitech-firmwareupdatetool"
      "lulu"
      "microsoft-auto-update"
      "microsoft-office"
      "minecraft"
      "moneymoney"
      "nvidia-geforce-now"
      "obsidian"
      "onyx"
      "porting-kit"
      "rectangle"
      "sidequest"
      "signal"
      "slack"
      "stats"
      "steam"
      "visual-studio-code"
      "visual-studio-code-insiders"
      "warp"
      "whatsapp"
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

    taps = [ "heroku/brew" "homebrew/cask-versions" "schappim/ocr" ];
  };
}
