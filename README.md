# dotfiles

## Setup

Install Homebrew and nix.

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh <(curl -L https://nixos.org/nix/install)
```

## Build

```
darwin-rebuild switch --flake .
```

## Update

```
nix --extra-experimental-features "nix-command flakes" flake update
```