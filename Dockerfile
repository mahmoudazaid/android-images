ARG BUILD_TOOLS=35.0.0

FROM mahmoudazaid/android-build-tools:${BUILD_TOOLS}

ENV DEBIAN_FRONTEND noninteractive

#=================================
# Android SDK configurations     #
#=================================
# Android15:    API_LEVEL="35   ##
# Android14:    API_LEVEL="34   ##
# Android13:    API_LEVEL="33   ##
# Android12L:   API_LEVEL="32   ##
# Android12:    API_LEVEL="31   ##
# Android11:    API_LEVEL="30"  ##
# Android10:    API_LEVEL="29"  ##
# Android9:     API_LEVEL="28"  ##
#=================================
LABEL version=14
ARG API_LEVEL="34"

ARG ARCH="x86_64"
ARG TARGET="google_apis_playstore"
ARG ANDROID_API_LEVEL="android-${API_LEVEL}"
ARG ANDROID_APIS="${TARGET};${ARCH}"
ENV EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
ARG PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
ARG ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION}"

# Set working directory
WORKDIR /

#=============================
# Install Dependencies
#=============================
SHELL ["/bin/bash", "-c"]

RUN apt update && apt install --no-install-recommends -y \
    tzdata curl wget unzip bzip2 libdrm-dev libxkbcommon-dev \
    libgbm-dev libasound-dev libnss3 libxcursor1 libpulse-dev \
    libxshmfence-dev xauth xvfb x11vnc fluxbox wmctrl \
    iputils-ping socat openbox python3-xdg procps git python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#=========================
# Copying Scripts to root
#=========================
COPY . /

#=========================
# Setting Executable Permissions
#=========================
RUN chmod a+x install-sdk-packages.sh

#====================================
# Run Scripts for SDK Package Installation
#====================================
RUN ./install-sdk-packages.sh --ANDROID_SDK_PACKAGES $ANDROID_SDK_PACKAGES

CMD [ "/bin/bash" ]
