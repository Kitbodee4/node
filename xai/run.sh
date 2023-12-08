#!/bin/bash

sudo apt update
sudo apt   install  screen
sudo apt install curl unzip
sudo apt upgrade
curl -L -o sentry-node-cli-linux.zip https://github.com/xai-foundation/sentry/releases/latest/download/sentry-node-cli-linux.zip

unzip sentry-node-cli-linux.zip

screen -S sentry-node-session -dm bash -c "./sentry-node-cli-linux"

sleep 2

screen -S sentry-node-session -X stuff "boot-operator$(printf \\r)"

screen -r sentry-node-session
