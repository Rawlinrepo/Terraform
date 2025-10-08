#!/bin/bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 24
# Enable pnpm
npm install -g pnpm
echo "$(node -v)"
echo "$(npm -v)"
echo "NODE + PNPM INSTALLED SUCCESSFULLY"

