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

#=================================
# Android SDK configurations     #
#=================================
# Android15:    API_LEVEL="35"
# Android14:    API_LEVEL="34"
# Android13:    API_LEVEL="33"
# Android12L:   API_LEVEL="32"
# Android12:    API_LEVEL="31"
# Android11:    API_LEVEL="30"
# Android10:    API_LEVEL="29"
# Android9:     API_LEVEL="28"
#=================================
LABEL ANDROID_VERSION=13
ENV API_LEVEL="33"

#============================#
# Android SDK Configurations #
#============================#
LABEL ANDROID_VERSION="15"
ARG API_LEVEL="35"
ARG ARCH="x86_64"
ARG TARGET="google_apis_playstore"
ARG ANDROID_API_LEVEL="android-${API_LEVEL}"
ARG ANDROID_APIS="${TARGET};${ARCH}"
ENV EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
ARG PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
ARG ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION}"

# Set working directory and use bash shell
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

#==============================#
# Install Android SDK Packages #
#==============================#
RUN ./install-sdk-packages.sh --ANDROID_SDK_PACKAGES "$ANDROID_SDK_PACKAGES"

#============================#
# Clean up unnecessary files #
#============================#
RUN rm -f ./install-node.sh ./install-appium.sh ./install-sdk-packages.sh && \
    rm -rf /tmp/* /var/tmp/*
    
#===========================#
# Default entrypoint script #
#===========================#
ENTRYPOINT ["/bin/bash", "-c", "if [ \"$APPIUM\" = \"true\" ]; then ./start-appium.sh; else /bin/bash; fi"]