./vault_setup.sh#!/bin/bash

# Define the path to the vault directory
VAULT_DIR="$HOME/secure_vault"

# Create the directory (the -p flag prevents errors if it already exists)
mkdir -p "$VAULT_DIR"

# Create the files and add welcome messages using I/O redirection (>)
echo "Welcome to the Keys File - Encryption Keys Stored Here" > "$VAULT_DIR/keys.txt"
echo "Welcome to the Secrets File - Confidential Data Stored Here" > "$VAULT_DIR/secrets.txt"
echo "Welcome to the Logs File - System Logs Stored Here" > "$VAULT_DIR/logs.txt"

# Print a success message
echo "✅ Success: Secure Vault directory and files have been created."

# List all files in long format to show the result
ls -l "$VAULT_DIR"
