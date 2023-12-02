#!/usr/bin/env bash
exporter_version="latest"

# Check if the first argument is "encrypt"
if [ "$1" = "encrypt" ]; then
    # Include the .gnupg volume
    docker run --rm \
        -v ./vars.yml:/app/vars.yml \
        -v ./backups:/app/backups \
        -v ${HOME}/.gnupg/:/root/.gnupg/:ro \
        bitwarden_exporter:$exporter_version ansible-playbook bitwarden_export.yml -e gpg_encrypt=True
else
    # Run without the .gnupg volume
    docker run --rm \
        -v ./vars.yml:/app/vars.yml \
        -v ./backups:/app/backups \
        bitwarden_exporter:$exporter_version ansible-playbook bitwarden_export.yml
fi
