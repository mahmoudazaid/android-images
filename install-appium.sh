#!/bin/bash

#============================================================#
# Exit immediately if a command exits with a non-zero status #
#============================================================#
set -e

#==================================================#
# Check if necessary environment variables are set #
#==================================================#
if [ -z "$APPIUM_VERSION" ]; then
    echo "Error: APPIUM_VERSION is not set."
    exit 1
fi

if [ -z "$UIAUTOMATOR_VERSION" ]; then
    echo "Error: UIAUTOMATOR_VERSION is not set."
    exit 1
fi

if [ -z "$DEVICE_FARM_VERSION" ]; then
    echo "Error: DEVICE_FARM_VERSION is not set."
    exit 1
fi

#================#
# Install Appium #
#================#
echo "Installing Appium version ${APPIUM_VERSION}..."
npm install -g "appium@${APPIUM_VERSION}"

#======================#
# Install UiAutomator2 #
#======================#
echo "Installing UiAutomator2 driver version ${UIAUTOMATOR_VERSION}..."
appium driver install "uiautomator2@${UIAUTOMATOR_VERSION}"

#============================#
# Install Device-Farm Plugin #
#============================#
echo "Installing Appium Device-Farm plugin version ${DEVICE_FARM_VERSION}..."
appium plugin install --source=npm "appium-device-farm@${DEVICE_FARM_VERSION}"

#=============#
# Cleaning Up #
#=============#
echo "Cleaning up unnecessary files..."
npm cache clean --force
apt-get purge -y npm && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /tmp/* /var/lib/apt/lists/*

echo "Appium installation completed successfully."