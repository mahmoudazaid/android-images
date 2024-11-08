# Android Images

## Badges
[![Build Status](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/mahmoudazaid/android-images/actions/workflows/docker-publish.yml)
![Build Tools Version](https://img.shields.io/badge/Build%20Tools-35.0.0-blue)
![Android Version](https://img.shields.io/badge/Android%20Version-14-blue)
![Android API](https://img.shields.io/badge/Android%20Version-34-blue)


## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Docker Image Details](#docker-image-details)
- [Environment Variables](#environment-variables)
- [Build and Run](#build-and-run)
- [Troubleshooting](#troubleshooting)

## Overview

This project uses a Docker container with the Android SDK to build Android applications, using build tools version `35.0.0` and targeting Android API Level 34.

## Requirements

- Docker (version 20.10+)
- Android SDK (version 34)
- Java JDK 8 or higher

## Docker Image Details

The Docker image is based on the official Android SDK image and is preconfigured with Android SDK packages and build tools.

### Android SDK Configurations

| Android Version | API Level | Build Tools Version |
|-----------------|-----------|---------------------|
| Android15       | 35        | 35.0.0              |
| Android14       | 34        | 35.0.0              |
| Android13       | 33        | 35.0.0              |
| Android12L      | 32        | 35.0.0              |
| Android12       | 31        | 35.0.0              |
| Android11       | 30        | 35.0.0              |
| Android10       | 29        | 35.0.0              |
| Android9        | 28        | 35.0.0              |

### Dockerfile Configuration

- **Build Tools Version:** `35.0.0`
- **Target API Level:** `34`
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
