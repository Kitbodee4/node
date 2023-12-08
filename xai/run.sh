#!/bin/bash
screen -S sentry-node-session -dm bash -c "./sentry-node-cli-linux"

# Wait for a moment to ensure the screen session is ready
sleep 2

# Send 'boot-operator' command to the screen session
screen -S sentry-node-session -X stuff "boot-operator$(printf \\r)"

# Reattach to the screen session
screen -r sentry-node-session
