#!/bin/bash

#=============================================#
# Install required packages using SDK manager #
#=============================================#

#======================================#
# Check if ANDROID_SDK_PACKAGES is set #
#======================================#
if [ -z "${ANDROID_SDK_PACKAGES}" ]; then
    echo "ANDROID_SDK_PACKAGES is not set. Exiting."
    exit 1
fi

#=================#
# Accept licenses #
#=================#
if ! yes | sdkmanager --licenses; then
    echo "Failed to accept licenses"
    exit 1
fi

#======================#
# Install SDK packages #
#======================#
if ! yes | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES}; then
    echo "Failed to install SDK packages"
    exit 1
fi
