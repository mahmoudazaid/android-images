#!/bin/bash

# Define colors for output
BL='\033[0;34m'
G='\033[0;32m'
RED='\033[0;31m'
YE='\033[1;33m'
NC='\033[0m' # No Color

#======================#
# Appium Configuration #
#======================#
APPIUM_PORT="${APPIUM_PORT:-4723}"
KEEP_ALIVE="${KEEP_ALIVE:-600}"
HUB_IP="${HUB_IP:-}"
HUB_PORT="${HUB_PORT:-4723}"  
BASE_PATH="${BASE_PATH:-/}"

#==============#
# Start Appium #
#==============#
printf "${G}==> ${BL}Starting Appium on port ${YE}${APPIUM_PORT}${G} with keep-alive ${YE}${KEEP_ALIVE}${G} ms and base path ${YE}${BASE_PATH}${G} <==${NC}\n"

#===============================#
# Build the base Appium command #
#===============================#
appium_command="appium server \
    --keep-alive ${KEEP_ALIVE} \
    --use-plugins=device-farm \
    --plugin-device-farm-platform=android \
    --port ${APPIUM_PORT} \
    --base-path ${BASE_PATH}"

#=======================================================#
# Add hub configuration only if HUB_IP is provided #
#=======================================================#
if [[ -n "${HUB_IP}" ]]; then
    printf "${G}==> ${BL}Configuring hub address to ${YE}${HUB_IP}${NC}\n"
    appium_command+=" --plugin-device-farm-hub=http://${HUB_IP}:${HUB_PORT}"
fi

#============================#
# Execute the Appium command #
#============================#
if ! eval "${appium_command}"; then
    printf "${RED}Error: Failed to start Appium server.${NC}\n"
    exit 1
fi
