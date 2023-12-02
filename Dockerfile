# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory in the container
WORKDIR /app/

# Install prereq packages
RUN apt update \
    && apt install gnupg jq unzip curl -y \
    && curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" --output /tmp/bw.zip  \
    && unzip /tmp/bw.zip -d /usr/local/bin \
    && chmod 755 /usr/local/bin/bw \
    && bw --version \
    && pip install --no-cache-dir ansible

# Copy the Ansible playbook and other necessary files into the container
COPY bitwarden_export.yml /app/bitwarden_export.yml

# Run Ansible playbook when the container launches
CMD ["ansible-playbook", "bitwarden_export.yml"]
