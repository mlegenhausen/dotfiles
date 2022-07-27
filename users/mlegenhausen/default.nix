{ pkgs, inputs, system, lib, ... }:

let
  username = "mlegenhausen";
  fullname = "Malte Legenhausen";

in {
  imports = [
    ../modules
  ];

  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; }) ];

  users.users.mlegenhausen = {
    name = "${username}";
    home = "/Users/${username}";
  };

  home-manager.users."${username}" = { pkgs, ... }: {
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
      nodePackages.typescript
      ocrmypdf
      pinentry_mac
      speedtest-cli
      yarn
      youtube-dl
    ];
    home.stateVersion = "22.05";

    programs = {
      home-manager.enable = true;

      direnv = import ./programs/direnv.nix { inherit pkgs; };

      git = {
        enable = true;
        userName = "${fullname}";
        userEmail = "${username}@mailbox.org";

        ignores = [ ".DS_Store" ".direnv" ];

        extraConfig = {
          core = { editor = "code-insiders --wait"; };
          github = { user = "${username}"; };
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

      gpg = { enable = true; };

      zsh = import ./programs/zsh.nix { inherit pkgs lib; };
    };
  };
}
