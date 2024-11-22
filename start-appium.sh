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
KEEP_ALIVE="${KEEP_ALIVE:-600}"             # Default keep-alive in ms
HUB_ADDRESS="${HUB_ADDRESS:-}"              # Optional hub IP
HUB_PORT="${HUB_PORT:-4723}"                # Default Hub port
BASE_PATH="${BASE_PATH:-}"                  # Default base path
PLATFORM="${PLATFORM:-both}"                # Default platform

#==============#
# Start Appium #
#==============#
printf "${G}==> ${BL}Starting Appium on port ${YE}${APPIUM_PORT}${G} with keep-alive ${YE}${KEEP_ALIVE}${G} ms and platform ${YE}${PLATFORM}${G} <==${NC}\n"

#===============================#
# Build the base Appium command #
#===============================#
appium_command="appium server --use-plugins=device-farm"

#===================================#
# Add Platform Configuration        #
#===================================#
printf "${G}==> ${BL}Configuring platform to ${YE}${PLATFORM}${NC}\n"
appium_command+=" --plugin-device-farm-platform=${PLATFORM}"

#===================================#
# Add Keep Alive Configuration      #
#===================================#
printf "${G}==> ${BL}Configuring --keep-alive to ${YE}${KEEP_ALIVE}${NC}\n"
appium_command+=" --keep-alive ${KEEP_ALIVE}"

#=================#
# Add Appium Port #
#=================#
printf "${G}==> ${BL}Configuring --port to ${YE}${APPIUM_PORT}${NC}\n"
appium_command+=" --port ${APPIUM_PORT}"

#=======================================================#
# Add hub configuration only if HUB_ADDRESS is provided #
#=======================================================#
if [[ -n "${HUB_ADDRESS}" ]]; then
    printf "${G}==> ${BL}Configuring hub address to ${YE}${HUB_ADDRESS}:${HUB_PORT}${NC}\n"
    appium_command+=" --plugin-device-farm-hub=http://${HUB_ADDRESS}:${HUB_PORT}"
fi

#===========================#
# Add base path if provided #
#===========================#
if [[ -n "${BASE_PATH}" ]]; then
    # Ensure BASE_PATH doesn't end with "/"
    BASE_PATH="${BASE_PATH%/}"
    printf "${G}==> ${BL}Using base path: ${YE}${BASE_PATH}${NC}\n"
    appium_command+=" --base-path ${BASE_PATH}"
fi

#============================#
# Execute the Appium command #
#============================#
if ! eval "${appium_command}"; then
    printf "${RED}Error: Failed to start Appium server.${NC}\n"
    exit 1
fi