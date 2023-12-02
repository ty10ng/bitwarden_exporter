# Bitwarden Export Data Playbook

## Overview

> **DISCLAIMER:** This Bitwarden Export Data Playbook is provided "as-is", without any warranty or guarantee of any kind. While every effort has been made to ensure the reliability and effectiveness of this playbook, users are advised to use it at their own risk. No responsibility is assumed by the authors for any consequences arising from the use or misuse of this playbook.

This project now utilizes Docker to encapsulate the Ansible playbook, simplifying the execution and management of the environment required for exporting account secrets and attachments from a self-hosted Bitwarden environment. The primary objective is to create raw backups of critical Bitwarden data (decoupled from the database) in JSON format and attachments for cold storage.

## Purpose
The playbook, now containerized, addresses the need for a robust backup strategy that doesn't solely rely on Bitwarden's internal mechanisms. It exports data in a raw, decrypted format, ensuring that critical information is readily available and can be restored independently of the Bitwarden server's state or database integrity.

## Requirements
- Docker installed on the host machine.
- A self-hosted Bitwarden server.
- GPG keys set up for encryption and decryption (if using encryption feature).
- A Slack webhook for notifications (optional).

## Docker Environment Setup
The Docker container includes all necessary dependencies, such as Ansible and the Bitwarden CLI. Before running the playbook, ensure Docker is properly set up and running on your system.

## Configuration File
Create a `vars.yml` file based on the provided `vars.example.yml` template. Fill in the Bitwarden credentials, server URL, GPG details, and Slack tokens.

## Running the Playbook
1. Build the Docker image using the provided Dockerfile:

   ```
   docker build -t bitwarden_exporter:latest .
   ```

2. Execute the `run.sh` script to run the Ansible playbook within the Docker container:

   ```
   ./run.sh [encrypt]
   ```

   Add the `encrypt` argument to enable GPG encryption.

## Notifications
- On successful completion, a message is sent to the configured Slack channel with details about the host and time of execution.
- In case of failure, a notification is sent to Slack with the hostname and timestamp, prompting for manual investigation.

## Cleanup
The Docker container ensures a clean environment for each run. Temporary files are managed within the container and do not persist after execution, reducing the need for manual cleanup.

## Security and Usage Note
- Dockerization adds a layer of security by isolating the playbook execution environment.
- Be mindful of Docker volume mounts to ensure sensitive information (like GPG keys and Slack tokens) is securely handled.
- Regularly update the Docker image to include the latest security patches and updates for dependencies.

## Your Contributions and Feedback

Contributions to enhance the Dockerized playbook are welcome. Share your improvements via pull requests or feedback to help evolve this project further.

