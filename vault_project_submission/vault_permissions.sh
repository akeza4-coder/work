#!/bin/bash

VAULT_DIR="$HOME/secure_vault"

# 1. Check if secure_vault exists
if [ ! -d "$VAULT_DIR" ]; then
    echo "❌ Error: secure_vault directory does not exist!"
    echo "Please run vault_setup.sh first."
    exit 1
fi

# 2. Use a function to handle permission updates
update_file_perm() {
    local filename=$1
    local default_perm=$2
    local filepath="$VAULT_DIR/$filename"

    echo "------------------------------------------------"
    echo "Current permission for $filename:"
    ls -l "$filepath"

    # Ask the user if they want to update
    read -p "Do you want to update permissions for $filename? (yes/no): " choice

    if [[ "$choice" == "yes" ]]; then
        read -p "Enter new permission (e.g., 600) or press Enter for default: " new_perm
        
        # If user presses Enter without input, use the default_perm
        if [[ -z "$new_perm" ]]; then
            chmod "$default_perm" "$filepath"
            echo "✅ Applied default permissions: $default_perm"
        else
            chmod "$new_perm" "$filepath"
            echo "✅ Applied custom permissions: $new_perm"
        fi
    else
        echo "Skipping $filename. Permissions left as is."
    fi
}

# 3. Call the function for each file with the required defaults
update_file_perm "keys.txt" "600"
update_file_perm "secrets.txt" "640"
update_file_perm "logs.txt" "644"

# 4. Display all file permissions at the end
echo -e "\n--- Final Vault Permissions ---"
ls -l "$VAULT_DIR"
