#!/bin/bash

#============================================================#
# Exit immediately if a command exits with a non-zero status #
#============================================================#
set -e

#==================================================#
# Check if necessary environment variables are set #
#==================================================#
if [ -z "$NODE_VERSION" ]; then
    echo "Error: NODE_VERSION is not set."
    exit 1
fi

if [ -z "$NPM_VERSION" ]; then
    echo "Error: NPM_VERSION is not set."
    exit 1
fi

#=================#
# Install Node.js #
#=================#
echo "Installing Node.js version ${NODE_VERSION}..."
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - || {
    echo "Error: Failed to download Node.js setup script."
    exit 1
}
apt-get install -y --no-install-recommends nodejs

#=============#
# Install npm #
#=============#
echo "Installing npm version ${NPM_VERSION}..."
npm install -g "npm@${NPM_VERSION}"

#=============#
# Cleaning Up #
#=============#
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo "Node.js and npm installation completed successfully."