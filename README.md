# dotfiles

## Setup

Install Homebrew and nix.

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh <(curl -L https://nixos.org/nix/install)
echo "run\tprivate/var/run" | sudo tee -a /etc/synthetic.conf
```

## Deployment

### MacBook Pro

```
nix \
  --extra-experimental-features "nix-command flakes" \
  build \
  github:mlegenhausen/dotfiles#darwinConfigurations.Maltes-MacBook-Pro.system \
  --no-write-lock-file
./result/sw/bin/darwin-rebuild switch --flake github:mlegenhausen/dotfiles#Maltes-MacBook-Pro
```

### MacBook Air

```
nix \
  --extra-experimental-features "nix-command flakes" \
  build \
  github:mlegenhausen/dotfiles#darwinConfigurations.Maltes-MacBook-Air.system \
  --no-write-lock-file
./result/sw/bin/darwin-rebuild switch --flake github:mlegenhausen/dotfiles#Maltes-MacBook-Air
```

### nix zsh as Default Shell

When starting a terminal the default shell will be the system shell. You need to switch manually to the nix installed zsh package by running the following command.

```
chsh -s /run/current-system/sw/bin/zsh
```

## Development

### Build

```
darwin-rebuild switch --flake .
```

### Update

```
nix --extra-experimental-features "nix-command flakes" flake update
```
