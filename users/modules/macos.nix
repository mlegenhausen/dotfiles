{ pkgs, lib, options, ... }:

{
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

    # universalaccess.reduceTransparency = true;
  };
}
