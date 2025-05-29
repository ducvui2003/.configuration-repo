#!/bin/bash

set -e  # Exit on error

echo "📦 Installing dependencies..."
sudo apt update && sudo apt install -y build-essential procps curl file git

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "✅ Homebrew installed!"
brew --version

echo "Install Brew file"
/bin/bash brew bundle --file=~/.dotfiles/Brewfile/Brewfile


