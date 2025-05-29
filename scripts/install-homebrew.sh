#!/bin/bash

set -e  # Exit on error

echo "📦 Installing dependencies..."
sudo apt update && sudo apt install -y build-essential procps curl file git

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


echo "🔧 Adding Homebrew to your ~/.bashrc..."

BREW_PATH_LINE='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

if ! grep -Fxq "$BREW_PATH_LINE" ~/.bashrc; then
    echo "$BREW_PATH_LINE" >> ~/.bashrc
    echo "✅ Added Homebrew path to ~/.bashrc"
else
    echo "✅ Homebrew path already present in ~/.bashrc"
fi

# Apply Homebrew to current session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "✅ Homebrew installed!"
brew --version

if [ -f ../Brewfile/Brewfile ]; then
    echo "📄 Found Brewfile, running brew bundle..."
    brew bundle --file=./Brewfile
else
    echo "ℹ️ No Brewfile found in current directory."
fi



