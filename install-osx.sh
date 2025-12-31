#!/bin/bash

cd "$(dirname "$0")"
brew bundle

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.cargo/env
rustup install nightly  # For cargo script support
