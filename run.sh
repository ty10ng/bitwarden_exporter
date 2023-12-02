#!/bin/bash

# Helper Script for Bitwarden Export Playbook

ENV_FILE="./env.sh"
PLAYBOOK="bitwarden_export.yml"

# Function to prompt for environment variables and create env.sh
prompt_for_variables() {
    echo "Enter the Bitwarden backup email:"
    read -r BITWARDEN_BACKUP_EMAIL

    echo "Enter the Bitwarden backup password:"
    read -s -r BITWARDEN_BACKUP_PASSWD
    echo

    echo "Enter the Bitwarden server URL:"
    read -r BITWARDEN_BACKUP_URL

    echo "Enter the GPG backup recipient:"
    read -r BITWARDEN_BACKUP_GPG_RECIPIENT

    echo "Enter the GPG backup passphrase:"
    read -s -r BITWARDEN_BACKUP_GPG_PASSPHRASE
    echo

    echo "Enter the backup folder path:"
    read -r BITWARDEN_BACKUP_FOLDER

    echo "Enter the Slack token:"
    read -r BITWARDEN_BACKUP_SLACK_TOKEN

    echo "Enter the Slack channel:"
    read -r BITWARDEN_BACKUP_SLACK_CHANNEL

    # Create env.sh with the provided values
    cat << EOF > "$ENV_FILE"
export BITWARDEN_BACKUP_EMAIL="$BITWARDEN_BACKUP_EMAIL"
export BITWARDEN_BACKUP_PASSWD="$BITWARDEN_BACKUP_PASSWD"
export BITWARDEN_BACKUP_URL="$BITWARDEN_BACKUP_URL"
export BITWARDEN_BACKUP_GPG_RECIPIENT="$BITWARDEN_BACKUP_GPG_RECIPIENT"
export BITWARDEN_BACKUP_GPG_PASSPHRASE="$BITWARDEN_BACKUP_GPG_PASSPHRASE"
export BITWARDEN_BACKUP_FOLDER="$BITWARDEN_BACKUP_FOLDER"
export BITWARDEN_BACKUP_SLACK_TOKEN="$BITWARDEN_BACKUP_SLACK_TOKEN"
export BITWARDEN_BACKUP_SLACK_CHANNEL="$BITWARDEN_BACKUP_SLACK_CHANNEL"
EOF
}

# Check if env.sh exists
if [ -f "$ENV_FILE" ]; then
    echo "Sourcing environment variables from $ENV_FILE"
    source "$ENV_FILE"
else
    echo "$ENV_FILE not found. Prompting for environment variables..."
    prompt_for_variables
    source "$ENV_FILE"
fi

# Execute the Ansible playbook
ansible-playbook "$PLAYBOOK"

