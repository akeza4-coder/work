#!/bin/bash

VAULT_DIR="$HOME/secure_vault"
SECRETS_FILE="$VAULT_DIR/secrets.txt"
LOGS_FILE="$VAULT_DIR/logs.txt"

# Loop until the user chooses to exit
while true; do
    echo -e "\n--- Secure Vault Operations ---"
    echo "1. Add Secret"
    echo "2. Update Secret"
    echo "3. Add Log Entry"
    echo "4. Access Keys"
    echo "5. Exit"
    read -p "Select an option: " choice

    case $choice in
        1)
            # Add Secret: Append a new line to the file
            read -p "Enter secret data to store: " new_secret
            echo "$new_secret" >> "$SECRETS_FILE"
            echo "✅ Secret added successfully."
            ;;
        2)
            # Update Secret: Search and replace using sed
            read -p "Enter the secret text to replace: " old_text
            read -p "Enter the new secret text: " new_text
            
            # Check if the old text exists first
            if grep -q "$old_text" "$SECRETS_FILE"; then
                sed -i "s/$old_text/$new_text/g" "$SECRETS_FILE"
                echo "✅ Secret updated successfully."
            else
                echo "❌ No match found."
            fi
            ;;
        3)
            # Add Log Entry: Append text with a timestamp
            read -p "Enter log entry: " log_content
            # The date command provides the current timestamp
            echo "[$(date)] - $log_content" >> "$LOGS_FILE"
            echo "✅ Log entry added."
            ;;
        4)
            # Access Keys: Block access as per requirements
            echo "ACCESS DENIED 🚫"
            ;;
        5)
            # Exit the loop
            echo "Closing Secure Vault. Goodbye!"
            break
            ;;
        *)
            # Handle invalid menu inputs
            echo "Invalid option. Please choose 1-5."
            ;;
    esac
done

