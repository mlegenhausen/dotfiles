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
      # cleanup = "uninstall";
      upgrade = true;
    };

    brews = [
      "imagemagick"
    ];

    casks = [
      "appcleaner"
      "browserosaurus"
      "chatgpt"
      "claude"
      "codex"
      "discord"
      "docker-desktop"
      "dropbox"
      "epic-games"
      "figma"
      "firefox@developer-edition"
      "fliqlo"
      "fujitsu-scansnap-home"
      "google-chrome"
      "iterm2"
      "keepingyouawake"
      "libreoffice"
      "licecap"
      "logi-options+"
      "logitech-camera-settings"
      "lulu"
      "minecraft"
      "moneymoney"
      "monologue"
      "ngrok"
      "onyx"
      "ollama-app"
      "rectangle"
      "signal"
      "stats"
      "steam"
      "tiptoi-manager"
      "teamviewer"
      "utm"
      "visual-studio-code"
      "visual-studio-code@insiders"
      # "whatsapp@beta"
      "vlc"
      "zed"
      "zoom"
    ];

    masApps = {
    #   "Amazon Prime Video" = 545519333;
      Bitwarden = 1352778147;
    #   "Home Assistent" = 1099568401;
      "Next Meeting" = 1017470484;
      "Okta Verify" = 490179405;
    #   # "RollerCoaster Tycoon Classic" = 1113736426;
      "WireGuard" = 1451685025;
    };
  };
}
