#!/bin/bash

if [ "$APPIUM" = "true" ]; then
    ./start-appium.sh
else
    tail -f /dev/null
fi