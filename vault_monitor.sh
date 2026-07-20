#!/bin/bash

VAULT_DIR="$HOME/secure_vault"
REPORT_FILE="$VAULT_DIR/vault_report.txt"

# Clear the report file if it exists and add a header
echo "--- VAULT SECURITY MONITORING REPORT ---" > "$REPORT_FILE"
echo "Generated on: $(date)" >> "$REPORT_FILE"
echo "----------------------------------------" >> "$REPORT_FILE"

# Loop through all files in the secure_vault directory
for file in "$VAULT_DIR"/*; do
    # Skip the report file itself to avoid self-monitoring
    if [[ "$(basename "$file")" == "vault_report.txt" ]]; then
        continue
    fi

    # Extract file metadata using the 'stat' command
    filename=$(basename "$file")
    filesize=$(stat -c%s "$file")    # %s = size in bytes
    last_mod=$(stat -c%y "$file")    # %y = human-readable modification time
    perms=$(stat -c%a "$file")       # %a = octal permissions (e.g., 644)

    # Log the details to the report file
    {
        echo "File: $filename"
        echo "Size: $filesize bytes"
        echo "Last Modified: $last_mod"
        echo "Permissions: $perms"
    } >> "$REPORT_FILE"

    # Check for Security Risks (if perms are numerically greater than 644)
    # 644 is owner:rw, group:r, others:r. Anything higher (like 666 or 777) is a risk.
    if [ "$perms" -gt 644 ]; then
        echo "⚠️ SECURITY RISK DETECTED: Permissions ($perms) are too open!" >> "$REPORT_FILE"
    fi

    echo "----------------------------------------" >> "$REPORT_FILE"
done

# Print confirmation to the terminal
echo "✅ Monitoring complete. The report has been saved to: $REPORT_FILE"
