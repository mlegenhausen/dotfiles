{ pkgs, inputs, system, lib, ... }:

let
  username = "mlegenhausen";
  fullname = "Malte Legenhausen";

in {
  imports = [ ../modules ];

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; }) ];

  users.users.mlegenhausen = {
    name = "${username}";
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users."${username}" = { pkgs, ... }: {
    home = {
      language = { base = "en_US.UTF-8"; };

      packages = with pkgs; [
        ast-grep
        colima
        difftastic
        eza
        ffmpeg
        gh
        gnupg
        gron
        imagemagick
        jdk11
        jq
        ncdu
        neofetch
        nmap
        nodejs
        nodePackages.npm-check-updates
        nodePackages.typescript
        ocrmypdf
        okta-aws-cli
        parallel
        pdftk
        pinentry_mac
        speedtest-cli
        vegeta
      ];

      sessionVariables = {
        NODE_ENV = "development";
      };

      stateVersion = "23.11";
    };

    programs = {
      home-manager.enable = true;

      direnv = import ./programs/direnv.nix { inherit pkgs; };

      git = {
        enable = true;
        userName = "${fullname}";
        userEmail = "${username}@mailbox.org";

        ignores = [ ".DS_Store" ".direnv" ".env" ".envrc" "TODO.md" ];

        delta = {
          enable = true;
          options = {
            syntax-theme = "Visual Studio Dark+";
            side-by-side = true;
          };
        };

        extraConfig = {
          commit = { verbose = true; };
          core = { editor = "code-insiders --wait"; };
          github = { user = "${username}"; };
          push = {
            autoSetupRemote = true;
            default = "simple";
          };
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

        # Build lazygit from latest source whilst we wait for a new release (for
        # Difftastic + commit co-authors).
        package = pkgs.lazygit.overrideAttrs (_: {
          src = pkgs.fetchFromGitHub {
            owner = "jesseduffield";
            repo = "lazygit";
            rev = "ad01745";
            hash = "sha256-NyTCknxqKFRFIg8b4/f3nYxqw+wEyugvQaZEBdWV/rc=";
          };
        });

        settings = {
          customCommands = [{
            key = "E";
            context = "global";
            command = "code {{.SelectedWorktree.Path}}";
          }];

          git = {
            # Override default to add `--oneline`. Default here:
            # https://github.com/jesseduffield/lazygit/blob/c390c9d58edc18083ed7f1a672b03b7c4d982c12/docs/Config.md
            branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";

            paging = {
              # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta
              colorArg = "always";
              pager = "delta --dark --paging=never";
            };
          };
          gui = { 
            showCommandLog = false;
            # sidePanelWidth = 0.3;
            showFileTree = false;

            theme = {
              # Workaround for https://github.com/jesseduffield/lazygit/issues/750
              selectedLineBgColor = [ "reverse" ];
              selectedRangeBgColor = [ "reverse" ];
            };

            # The default is "flexible". We don't ever want "horizontal" layout
            # because it conflicts with side-by-side diffs.
            mainPanelSplitMode = "vertical";
          };
          os = { open = "code-insiders -rg {{filename}}"; };
          promptToReturnFromSubprocess = false;
          refresher = { refreshInterval = 5; };
        };
      };

      zsh = import ./programs/zsh.nix { inherit pkgs lib; };
    };
  };
}
