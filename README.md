# Android Images

## Badges
[![Docker Publish](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml)
![SDK Version](https://img.shields.io/badge/SDK%20Version-35.0.0-blue)
![Android Version](https://img.shields.io/badge/Android%20Version-14-blue)
![API Level](https://img.shields.io/badge/API%20Level-34-blue)


## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Docker Image Details](#docker-image-details)
- [Environment Variables](#environment-variables)
- [Build and Run](#build-and-run)
- [Troubleshooting](#troubleshooting)

## Overview

This project uses a Docker container with the Android SDK to build Android applications, using build tools.

## Requirements

- Docker (version 20.10+)

## Docker Image Details

The Docker image is based on the official Android SDK image and is preconfigured with Android SDK packages and build tools.

### Android Versions

| Android Version | API Level |
|-----------------|-----------|
| Android15       | 35        |
| Android14       | 34        |
| Android13       | 33        |
| Android12L      | 32        |
| Android12       | 31        |
| Android11       | 30        |
| Android10       | 29        |
| Android9        | 28        |

### Dockerfile Configuration

- **Build Tools Version:** `35.0.0`
- **Target API Level:** `35`
- **Architecture:** `x86_64`
- **Target System Image:** `google_apis_playstore`
- **Platform Version:** `platforms;android-34`

## Environment Variables

Ensure the following environment variables are set for the Docker container:

- `ANDROID_SDK_ROOT`: The path to the Android SDK in the Docker container.
- `ANDROID_HOME`: The location of the Android SDK installation.
- `JAVA_HOME`: The location of the installed JDK.
- `BUILD_TOOLS`: Version of Android build tools (default is `35.0.0`).

Example:
```bash
export ANDROID_SDK_ROOT=/path/to/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export JAVA_HOME=/path/to/java
export BUILD_TOOLS=35.0.0