#!/bin/bash

# Setup SSH keys with proper permissions
if [ -d "/tmp/.ssh-localhost" ]; then
    echo "Setting up SSH keys..."
    
    # Create .ssh directory if it doesn't exist
    mkdir -p /home/vscode/.ssh
    
    # Copy SSH files (this will overwrite any existing files)
    cp -f /tmp/.ssh-localhost/* /home/vscode/.ssh/ 2>/dev/null || true
    
    # Set proper ownership and permissions
    chown -R vscode:vscode /home/vscode/.ssh
    chmod 700 /home/vscode/.ssh
    
    # Set permissions for individual files
    if [ -f /home/vscode/.ssh/config ]; then
        chmod 644 /home/vscode/.ssh/config
    fi
    
    # Set permissions for private keys
    chmod 600 /home/vscode/.ssh/id_* 2>/dev/null || true
    
    # Set permissions for public keys
    chmod 644 /home/vscode/.ssh/*.pub 2>/dev/null || true
    
    # Set permissions for known_hosts
    chmod 644 /home/vscode/.ssh/known_hosts* 2>/dev/null || true
    
    echo "SSH keys setup complete."
else
    echo "No SSH keys found to setup."
fi

