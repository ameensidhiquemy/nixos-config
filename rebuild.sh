
#!/bin/bash
sudo -E NIX_PATH="nixos-config=$HOME/nixos-config/configuration.nix:nixos=/nix/var/nix/profiles/per-user/root/channels/nixos:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" nixos-rebuild "$@"
