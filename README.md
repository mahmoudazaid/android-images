# Android Image with Appium, Device-Farm, and UIAutomator

This project provides a **base Docker image** configured with Android SDK, Appium, Device-Farm plugin, and UIAutomator. It is designed to be used as a foundation for creating custom Docker images that run Android emulators. The base image includes all necessary setups to create and run emulators and also supports using Appium in a node or hub configuration.

You can use this image to build your own Docker container with emulators, run Appium, or just use it for Android development purposes.

## Badges

[![Docker Publish](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml)  
![SDK Version](https://img.shields.io/badge/SDK%20Version-35.0.0-blue)
![Android Version](https://img.shields.io/badge/Android%20Version-15-blue)
![API Level](https://img.shields.io/badge/API%20Level-35-blue)  
![Node Version](https://img.shields.io/badge/node-22.x-blue)
![npm Version](https://img.shields.io/badge/npm-10.9.0-blue)  
![Appium Version](https://img.shields.io/badge/appium-2.12.1-blue)
![UiAutomator Version](https://img.shields.io/badge/uiautomator2-3.8.0-blue)
![Device-Farm Version](https://img.shields.io/badge/device_farm-9.2.3-blue)

## Table of Contents

1. [Project Overview](#project-overview)
2. [How to Build](#how-to-build)
   - [Build without passing any arguments](#1-build-without-passing-any-arguments)
   - [Build with specific arguments](#2-build-with-specific-arguments)
3. [How to Run](#how-to-run)
   - [Run with default settings](#3-run-with-default-settings)
   - [Run with customized settings](#4-run-with-customized-settings)
   - [Additional Appium Configurations](#5-additional-appium-configurations)
4. [Build and Run Variables](#build-and-run-variables)
   - [Build Variables](#build-variables)
   - [Run Variables](#run-variables)
5. [Troubleshooting](#troubleshooting)
6. [License](#license)

## Project Overview

- **Base Image**: This image is intended to be used as a starting point for creating custom Docker images that run Android emulators.
- **Appium Integration**: Appium is pre-configured with the Device-Farm plugin and UIAutomator to run automated tests on Android emulators.
- **Customizable**: You can configure the image to either automatically run Appium or use it purely as an emulator environment for Android development.

## Prerequisites

- Docker
- Basic knowledge of Appium and Android Emulator setup

## How to Build

### 1. Build without passing any arguments

To build the Docker image without any specific arguments, run the following command:

```bash
docker build -t android-appium .
```

This command uses the default BUILD_TOOLS_VERSION=35.0.0 and other configurations as specified in the Dockerfile.

### 2. Build with specific arguments

To pass custom arguments during the build process, use the `--build-arg` flag. For example:

```bash
docker build --build-arg BUILD_TOOLS_VERSION=36.0.0 --build-arg ANDROID_VERSION=14 -t android-appium .
```

This will build the Docker image using the specified `BUILD_TOOLS_VERSION` and `ANDROID_VERSION` .

## How to Run

### 3. Run the image with default settings

To run the Docker image using the default configuration (Appium not running), use the following command:

```bash
docker run -it android-appium
```

This will start the container and leave you in a bash shell with the default Android environment.

### 4. Run with customized settings

To start the Docker container with customized variables (for example, running Appium), you can pass the necessary environment variables when running the container. Example:

```bash
docker run -it -e APPIUM=true -e APPIUM_PORT=4725 android-appium
```

This will start Appium with the custom port (`4725`), instead of the default (`4723`) .

### 5. Additional Appium Configurations

You can pass other environment variables to customize the Appium server configuration. Some of the key variables are:

- `APPIUM=true` to start Appium server
- `APPIUM_PORT=4723` to set the Appium port
- `KEEP_ALIVE=600` to specify the keep-alive timeout (in milliseconds)
- `HUB_ADDRESS` to set a specific hub address for the Appium server to connect to

Example:

```bash
docker run -it -e APPIUM=true -e APPIUM_PORT=4725 -e HUB_ADDRESS="hub.example.com" android-appium
```

## Build and Run Variables

### Build Variables

| **Variable**           | **Description**                                                       | **Default Value**                                       |
| ---------------------- | --------------------------------------------------------------------- | ------------------------------------------------------- |
| `BUILD_TOOLS_VERSION`  | Specifies the version of the Android Build Tools to install.          | `35.0.0`                                                |
| `ANDROID_VERSION`      | Specifies the Android version to use for the base image.              | `13`                                                    |
| `API_LEVEL`            | Defines the Android API level to be installed.                        | `33`                                                    |
| `ARCH`                 | Architecture for the Android emulator image (e.g., `x86_64`).         | `x86_64`                                                |
| `TARGET`               | The target platform for the emulator (e.g., `google_apis_playstore`). | `google_apis_playstore`                                 |
| `EMULATOR_PACKAGE`     | Android system image package to install for emulators.                | `system-images;android-33;google_apis_playstore;x86_64` |
| `PLATFORM_VERSION`     | The platform version for the Android SDK.                             | `platforms;android-33`                                  |
| `ANDROID_SDK_PACKAGES` | List of Android SDK packages to install.                              | `${EMULATOR_PACKAGE} ${PLATFORM_VERSION}`               |

### Run Variables

| **Variable**  | **Description**                                               | **Default Value** |
| ------------- | ------------------------------------------------------------- | ----------------- |
| `APPIUM`      | Whether to start Appium or not. Set to `true` to run Appium.  | `false`           |
| `APPIUM_PORT` | The port on which Appium will run.                            | `4723`            |
| `KEEP_ALIVE`  | The keep-alive timeout in milliseconds for the Appium server. | `600`             |
| `HUB_ADDRESS` | The address of the Appium Hub, if using a hub setup.          | `""` (empty)      |

## Troubleshooting

- If Appium fails to start, check the logs for errors. Common issues include incorrect port or network configurations.
- Ensure the required Android SDK packages and system dependencies are correctly installed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
