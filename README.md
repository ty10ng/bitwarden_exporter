# Bitwarden Export Data Playbook


## Overview

> **DISCLAIMER:** This Bitwarden Export Data Playbook is provided "as-is", without any warranty or guarantee of any kind. While every effort has been made to ensure the reliability and effectiveness of this playbook, the users are advised to use it at their own risk. No responsibility is assumed by the authors for any consequences arising from the use or misuse of this playbook.

This Ansible playbook is specifically designed for exporting account secrets and attachments from a self-hosted Bitwarden environment. The primary objective is to create raw backups of critical Bitwarden data (decoupled from the database) in the form of JSON data and attachments. These backups are intended for cold storage, providing a reliable 'break-glass' solution in emergency scenarios where standard recovery processes might not be feasible or if the `bwdata` folder for Bitwarden is not available or corrupted.

## Purpose
The playbook addresses the need for a robust backup strategy that doesn't solely rely on Bitwarden's internal backup mechanisms or the `bwdata` folder. By exporting data directly in a raw, decrypted format, it ensures that critical information is readily available and can be restored independently of the Bitwarden server's state or database integrity. This approach is particularly valuable in scenarios where immediate access to secured data is essential, and traditional recovery methods are not an option.

## Requirements
- Ansible installed on the host machine. (I built this playbook for Ubuntu 22.04.3 LTS)
- A self-hosted Bitwarden server.
- GPG keys set up for encryption and decryption.
- A Slack webhook for notifications. (Optional; set the token environment variable to an empty string to skip notifications)

## Environment Variables
Set the following environment variables before running the playbook:
- `BITWARDEN_BACKUP_EMAIL`: Email for the Bitwarden account.
- `BITWARDEN_BACKUP_PASSWD`: Password for the Bitwarden account.
- `BITWARDEN_BACKUP_URL`: URL of the self-hosted Bitwarden server.
- `BITWARDEN_BACKUP_GPG_RECIPIENT`: GPG recipient for encryption.
- `BITWARDEN_BACKUP_GPG_PASSPHRASE`: Passphrase for GPG encryption.
- `BITWARDEN_BACKUP_FOLDER`: Directory path for storing backups.
- `BITWARDEN_BACKUP_SLACK_TOKEN`: Slack API token for notifications.
- `BITWARDEN_BACKUP_SLACK_CHANNEL`: Slack channel for notifications.

## Lock File Mechanism
The playbook uses a lock file (`bitwarden_export_playbook.lock`) in the backup directory to prevent concurrent executions. If this file exists, it indicates that an instance of the playbook is already running, or an error happened that requires manual intervention.

## Running the Playbook
1. Ensure all required environment variables are set.
2. Run the playbook using: `ansible-playbook bitwarden_export.yml`.
3. Check Slack for success or failure notifications.

## Notifications
- On successful completion, a message is sent to the configured Slack channel with details about the host and time of execution.
- In case of failure, a notification is sent to Slack with the hostname and timestamp, prompting for manual investigation.

## Cleanup
The playbook includes a cleanup step to remove temporary (unencrypted) files related to the backup job.

## Security and Usage Note
- Handle sensitive information, like passwords and tokens, with utmost care.
- The provided helper script creates an `env.sh` file for storing environment variables. This file is essential for running the playbook, especially for scheduled backups.
- Ensure the `env.sh` file is securely stored and accessible only to authorized personnel, as it contains sensitive data, including your GPG key password (if present).

## Your Contributions and Feedback

I'm always open to improvements and value your input to make this project better. Feel free to tweak the playbook to fit your needs, and I'd love to hear about how you're using and enhancing it.

If you've made changes that you believe enhance the playbook, I encourage you to share them. A simple pull request is all it takes to bring your improvements into the fold.


