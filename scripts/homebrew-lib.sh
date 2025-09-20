#!/bin/bash
set -e

echo "Restore brew"

brew bundle --file=./Brewfile
