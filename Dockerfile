# Set build tools version (default 35.0.0) and base image
ARG BUILD_TOOLS_VERSION=35.0.0
FROM mahmoudazaid/android-build-tools:${BUILD_TOOLS_VERSION}

#=============================#
# Prevent interaction prompts #
#=============================#
ENV DEBIAN_FRONTEND=noninteractive

#===============================#
# Set Appium not run by default #
#===============================#
ENV APPIUM=false

#=====================#
# APPIUM Version ARGs #
#=====================#
ARG APPIUM_VERSION="2.12.1"
ARG UIAUTOMATOR_VERSION="3.8.0"
ARG DEVICE_FARM_VERSION="9.2.3"


#===================#
# Node Version ARGs #
#===================#
ARG NODE_VERSION="22"
ARG NPM_VERSION="10.9.0"

#================================#
# Android SDK configurations     #
#================================#
LABEL ANDROID_VERSION=15
ARG API_LEVEL="35"

ARG ARCH="x86_64"
ARG TARGET="google_apis_playstore"
ARG ANDROID_API_LEVEL="android-${API_LEVEL}"
ARG ANDROID_APIS="${TARGET};${ARCH}"
ENV EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
ARG PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
ARG ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION}"

#==========================================#
# Set working directory and use bash shell #
#==========================================#
WORKDIR /
SHELL ["/bin/bash", "-c"]

#=============================#
# Install System Dependencies #
#=============================#
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    tzdata \
    curl \
    wget \
    unzip \
    bzip2 \
    libnss3 \
    xauth \
    xvfb \
    procps && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#======================================#
# Copy and Set Permissions for Scripts #
#======================================#
COPY . /
RUN chmod +x ./install-node.sh ./install-appium.sh ./install-sdk-packages.sh ./start-appium.sh

#=============#
# Run Scripts #
#=============#
RUN ./install-node.sh \
    --NODE_VERSION=${NODE_VERSION} --NPM_VERSION=${NPM_VERSION}

RUN ./install-appium.sh \ 
    --APPIUM_VERSION=${APPIUM_VERSION} \
    --UIAUTOMATOR_VERSION=${UIAUTOMATOR_VERSION} \
    --DEVICE_FARM_VERSION=${DEVICE_FARM_VERSION}

RUN ./install-sdk-packages.sh \
    --ANDROID_SDK_PACKAGES "$ANDROID_SDK_PACKAGES"

#============================#
# Clean up unnecessary files #
#============================#
RUN rm -f ./install-node.sh ./install-appium.sh ./install-sdk-packages.sh && \
    rm -rf /tmp/* /var/tmp/*

#===========================#
# Default entrypoint script #
#===========================#
ENTRYPOINT ["/bin/bash", "-c", "if [ \"$APPIUM\" = \"true\" ]; then ./start-appium.sh; else tail -f /dev/null; fi"]