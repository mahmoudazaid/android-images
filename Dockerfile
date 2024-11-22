ARG BUILD_TOOLS_VERSION=35.0.0
FROM mahmoudazaid/android-build-tools:${BUILD_TOOLS_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /

#======================#
# Install Dependencies #
#======================#
SHELL ["/bin/bash", "-c"]

RUN apt update && apt install --no-install-recommends -y \
    tzdata \
    curl \
    git \
    sudo \
    wget \
    unzip \
    bzip2 \
    libdrm-dev \
    libxkbcommon-dev \
    libgbm-dev \
    libasound-dev \
    libnss3 \
    libxcursor1 \
    libpulse-dev \
    libxshmfence-dev \
    xauth \
    xvfb \
    x11vnc \
    fluxbox \
    wmctrl \
    libdbus-glib-1-2 \
    iputils-ping \
    net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#===================#
# Node Version ARGs #
#===================#
ARG NODE_VERSION=22
ARG NPM_VERSION=10.9.1

#=====================#
# APPIUM Version ARGs #
#=====================#
ARG APPIUM_VERSION=2.12.1
ARG UIAUTOMATOR_VERSION=3.8.0
ARG DEVICE_FARM_VERSION=9.4.6

#===================================#
# Copying necessary scripts to root #
#===================================#
COPY install-node.sh install-appium.sh start.sh /

#================================#
# Setting Executable Permissions #
#================================#
RUN chmod a+x install-node.sh install-appium.sh start.sh

#=============#
# Run Scripts #
#=============#
RUN ./install-node.sh \
    --NODE_VERSION=${NODE_VERSION} --NPM_VERSION=${NPM_VERSION}

RUN ./install-appium.sh \ 
    --APPIUM_VERSION=${APPIUM_VERSION} \
    --UIAUTOMATOR_VERSION=${UIAUTOMATOR_VERSION} \
    --DEVICE_FARM_VERSION=${DEVICE_FARM_VERSION}

#============================================#
# Clean up the installation files and caches #
#============================================#
RUN rm -f install-node.sh install-appium.sh && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

#==============================#
# Command to run the container #
#==============================#
CMD ["./start.sh"]