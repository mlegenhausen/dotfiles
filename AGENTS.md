# Repository Guide

## Structure

- This is a Nix flake for two `aarch64-darwin` nix-darwin systems: `Maltes-MacBook-Pro` and `Maltes-MacBook-Air`.
- `flake.nix` is the entrypoint; `machines/` contains host-specific settings, while `users/modules/` contains shared system modules.
- `users/mlegenhausen/default.nix` owns the user and Home Manager configuration; its `programs/` files configure user-level tools.

## Workflow

- Use Nix with flakes enabled. `.envrc` loads `shell.nix` through nix-direnv; the shell provides `nixfmt`.
- Evaluate the flake with `nix --extra-experimental-features "nix-command flakes" flake check --no-write-lock-file`.
- Build a host with `nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.<host>.system --no-write-lock-file`, then switch with `./result/sw/bin/darwin-rebuild switch --flake .#<host>`.
- The `<host>` values are exactly `Maltes-MacBook-Pro` and `Maltes-MacBook-Air`; `darwin-rebuild switch --flake .` is the local development shortcut.
- `nix --extra-experimental-features "nix-command flakes" flake update` changes `flake.lock`; use it only for intentional dependency updates.
- Deployment activates Homebrew with automatic update and upgrade enabled, so do not run a switch casually.

## Verification

- There are no repository test, lint, typecheck, or codegen commands; `nix flake check` is the available evaluation check.
- Format only touched Nix files with `nixfmt`. A repo-wide `nixfmt --check $(git ls-files '*.nix')` currently reports pre-existing formatting failures; avoid unrelated reformatting.
- `users/mlegenhausen/programs/opencode/AGENTS.md` is passed as the configured OpenCode context. Preserve its review-delegation policy when changing OpenCode configuration.
