{ pkgs, inputs, system, lib, ... }:

let
  username = "mlegenhausen";
  fullname = "Malte Legenhausen";

in {
  imports = [ ../modules ];

  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; }) ];

  users.users.mlegenhausen = {
    name = "${username}";
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.users."${username}" = { pkgs, ... }: {
    home = {
      language = { base = "en_US.UTF-8"; };

      packages = with pkgs; [
        docker-machine
        exa
        ffmpeg
        gnupg
        imagemagick
        jdk11
        jq
        neofetch
        nmap
        nodejs
        nodePackages.npm-check-updates
        nodePackages.typescript
        ocrmypdf
        parallel
        pinentry_mac
        speedtest-cli
        terraform
        yarn
        vegeta
        youtube-dl
      ];

      sessionVariables = {
        NODE_ENV = "development";
      };

      stateVersion = "22.11";
    };

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

      lazygit = {
        enable = true;

        settings = {
          gui = { showIcons = true; };
          os = { openCommand = "code-insiders -rg {{filename}}"; };
          promptToReturnFromSubprocess = false;
          refresher = { refreshInterval = 5; };
        };
      };

      zsh = import ./programs/zsh.nix { inherit pkgs lib; };
    };
  };
}
