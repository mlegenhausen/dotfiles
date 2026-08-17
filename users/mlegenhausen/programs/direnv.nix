{ pkgs, ... }:

{
  enable = true;
  enableZshIntegration = true;
  nix-direnv.enable = true;

  # Avoid cluttering project directories which often conflicts with tooling,
  # as per:
  #   https://github.com/direnv/direnv/wiki/Customizing-cache-location
  stdlib = ''
    : ''${XDG_CACHE_HOME:=$HOME/.cache}
    declare -A direnv_layout_dirs
    direnv_layout_dir() {
      echo "''${direnv_layout_dirs[$PWD]:=$(
        echo -n "$XDG_CACHE_HOME"/direnv/layouts/
        echo -n "$PWD" | ${pkgs.coreutils}/bin/sha1sum | cut -d ' ' -f 1
      )}"
    }
  '';
}
