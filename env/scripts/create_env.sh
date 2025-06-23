#!/bin/bash

ENV_FILE="./docker/.env"

USER_NAME=user
GROUP_NAME=user
DISPLAY_VAL="${DISPLAY:-:0}"
NUM_UID=$(id -u)
NUM_GID=$(id -g)

if [ ! -f "${ENV_FILE}" ]; then
    echo "Creating new ${ENV_FILE}."
    cat <<EOF > "${ENV_FILE}"
NVIDIA_VISIBLE_DEVICES=all
NVIDIA_DRIVER_CAPABILITIES=all
DISPLAY=${DISPLAY_VAL}
USER_NAME=${USER_NAME}
GROUP_NAME=${GROUP_NAME}
XDG_CONFIG_HOME=/home/${USER_NAME}/.config
XDG_RUNTIME_DIR=run/user
NUM_UID=${NUM_UID}
NUM_GID=${NUM_GID}
EOF
    echo "Created ${ENV_FILE} with current environment values."
else
    echo "${ENV_FILE} already exists. Skipping."
fi


