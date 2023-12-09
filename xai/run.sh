#!/bin/bash

timestamp=$(date '+%Y%m%d%H%M%S')
sentry="sentry-node-session-$timestamp"
sudo apt update
sudo apt   install  screen
sudo apt install curl unzip
@@ -8,10 +9,10 @@ curl -L -0 -o sentry-node-cli-linux.zip https://github.com/xai-foundation/sentry

unzip -o sentry-node-cli-linux.zip

screen -S sentry-node-session -dm bash -c "./sentry-node-cli-linux"
screen -S  "$sentry" -dm bash -c "./sentry-node-cli-linux"

sleep 2

screen -S sentry-node-session -X stuff "boot-operator$(printf \\r)"
screen -S "$sentry" -X stuff "boot-operator$(printf \\r)"

screen -r sentry-node-session
screen -r "$sentry"
