#!/bin/bash

# Define colors for output
BL='\033[0;34m'    # Blue
G='\033[0;32m'     # Green
RED='\033[0;31m'   # Red
YE='\033[1;33m'    # Yellow
NC='\033[0m'       # No Color

#======================#
# Appium Configuration #
#======================#
# Default configuration values
APPIUM_PORT="${APPIUM_PORT:-4723}"           # Default Appium port
KEEP_ALIVE="${KEEP_ALIVE:-600}"              # Default keep-alive in ms
HUB_IP="${HUB_IP:-}"                         # Optional hub IP
HUB_PORT="${HUB_PORT:-4723}"                 # Default Hub port
BASE_PATH="${BASE_PATH:-}"                  # Default base path

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
    printf "${G}==> ${BL}Configuring hub address to ${YE}${HUB_IP}:${HUB_PORT}${NC}\n"
    appium_command+=" --plugin-device-farm-hub=http://${HUB_IP}:${HUB_PORT}"
fi

#============================#
# Execute the Appium command #
#============================#
if ! eval "${appium_command}"; then
    printf "${RED}Error: Failed to start Appium server.${NC}\n"
    exit 1
fi