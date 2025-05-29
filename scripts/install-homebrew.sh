#!/bin/bash
set -e

echo "🔄 Updating packages and installing dependencies..."
sudo apt update
sudo apt install -y build-essential curl file git

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

BREW_ENV='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

# Add Homebrew environment setup to ~/.bashrc if not present
if ! grep -Fxq "$BREW_ENV" ~/.bashrc; then
    echo "$BREW_ENV" >> ~/.bashrc
    echo "✅ Added Homebrew environment setup to ~/.bashrc"
else
    echo "✅ Homebrew environment setup already present in ~/.bashrc"
fi

echo "♻️ Loading Homebrew environment in current shell..."
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "🎉 Homebrew installed successfully!"
brew --version

echo "ℹ️ Please restart your terminal or run 'source ~/.bashrc' to load Homebrew automatically in new sessions."
