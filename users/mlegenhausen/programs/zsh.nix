{ pkgs, lib, ... }:

{
  enable = true;

  shellAliases = {
    # Fix for permission denied error when using `..`.
    ".." = "cd ..";
  };

  zplug = {
    enable = true;

    plugins = [
      {
        name = "lib/directories";
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

  shellAliases = {
    code = "code-insiders";
    l = "exa --git -la";
    ll = "exa --git -l";
    ls = "exa";
    lg = "lazygit";
    pbapply = "pbpaste | git apply";
    pbdiff = "git diff | pbcopy";
  };
}
