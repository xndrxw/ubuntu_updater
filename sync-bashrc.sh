#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/ubuntu_updater}"
TARGET_FILE="$REPO_DIR/.bashrc"
HOME_BASHRC="$HOME/.bashrc"

if [ ! -f "$TARGET_FILE" ]; then
  printf 'Missing %s\n' "$TARGET_FILE" >&2
  exit 1
fi

if [ ! -L "$HOME_BASHRC" ]; then
  printf 'Warning: %s is not a symlink to repo .bashrc\n' "$HOME_BASHRC"
fi

if [ -L "$HOME_BASHRC" ] && [ "$(readlink -f "$HOME_BASHRC")" != "$TARGET_FILE" ]; then
  printf 'Warning: %s points to %s, expected %s\n' "$HOME_BASHRC" "$(readlink -f "$HOME_BASHRC")" "$TARGET_FILE"
fi

git -C "$REPO_DIR" pull --rebase
git -C "$REPO_DIR" add .bashrc

if git -C "$REPO_DIR" diff --cached --quiet; then
  printf 'No .bashrc changes to sync.\n'
  exit 0
fi

message="${1:-sync: update bashrc}"
git -C "$REPO_DIR" commit -m "$message"
git -C "$REPO_DIR" push

printf 'Synced .bashrc to GitHub.\n'
