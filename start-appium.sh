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
HUB_ADDRESS="${HUB_ADDRESS:-}"
HUB_NAME="${HUB_NAME:-}"

#==============#
# Start Appium #
#==============#
printf "${G}==> ${BL}Starting Appium on port ${YE}${APPIUM_PORT}${G} with keep-alive ${YE}${KEEP_ALIVE}${G} ms <==${NC}\n"

#===============================#
# Get the HUB_ADDRESS if HUB_NAME is set #
#===============================#
if [[ -n "${HUB_NAME}" ]]; then
    HUB_ADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${HUB_NAME}")
    if [[ -z "${HUB_ADDRESS}" ]]; then
        printf "${RED}Error: Could not retrieve IP address for container ${HUB_NAME}.${NC}\n"
        exit 1
    fi
    printf "${G}==> ${BL}Resolved HUB_NAME (${YE}${HUB_NAME}${BL}) to IP address ${YE}${HUB_ADDRESS}${NC}\n"
fi

#===============================#
# Build the base Appium command #
#===============================#
appium_command="appium server \
    --keep-alive ${KEEP_ALIVE} \
    --use-plugins=device-farm \
    --plugin-device-farm-platform=android \
    --port ${APPIUM_PORT} \
    --base-path /wd/hub"

#=======================================================#
# Add hub configuration only if HUB_ADDRESS is provided #
#=======================================================#
if [[ -n "${HUB_ADDRESS}" ]]; then
    printf "${G}==> ${BL}Configuring hub address to ${YE}${HUB_ADDRESS}${NC}\n"
    appium_command+=" --plugin-device-farm-hub=http://${HUB_ADDRESS}:${APPIUM_PORT}"
fi

#============================#
# Execute the Appium command #
#============================#
if ! eval "${appium_command}"; then
    printf "${RED}Error: Failed to start Appium server.${NC}\n"
    exit 1
fi