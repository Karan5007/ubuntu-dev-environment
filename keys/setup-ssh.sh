#!/bin/bash

# Check if the public key exists and copy it to authorized_keys
if [ -f /shared/ssh_key.pub ]; then
    cat /shared/ssh_key.pub >> /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    echo "SSH public key copied successfully."
else
    echo "SSH public key not found in /shared/ssh_key.pub. Make sure the key is available."
fi

# Check if the private key exists and copy it to ~/.ssh/
if [ -f /shared/ssh_key ]; then
    cp /shared/ssh_key /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    echo "SSH private key copied successfully."
else
    echo "SSH private key not found in /shared/ssh_key. Make sure the key is available."
fi
