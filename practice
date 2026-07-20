#!/bin/bash

# 1. Ask for project name
echo "Enter project name:"
read input
PROJECT="attendance_tracker_${input}"

# 2. Handle Ctrl+C
trap 'echo ""; echo "Interrupt detected. Archiving..."; tar -czf "${PROJECT}_archive.tar.gz" "$PROJECT"; rm -rf "$PROJECT"; exit 1' SIGINT

# 3. Create folder structure
mkdir -p "$PROJECT/Helpers"
mkdir -p "$PROJECT/reports"

# 4. Copy teacher files (already placed in attendance_tracker_school_tracker)
cp attendance_tracker_school_tracker/attendance_checker.py "$PROJECT/"
cp attendance_tracker_school_tracker/Helpers/assets.csv "$PROJECT/Helpers/"
cp attendance_tracker_school_tracker/Helpers/config.json "$PROJECT/Helpers/"
cp attendance_tracker_school_tracker/reports/reports.log "$PROJECT/reports/"

# 5. Update thresholds if user wants
echo "Do you want to change attendance thresholds? (y/n)"
read ans
if [ "$ans" = "y" ]; then
    echo "Enter warning threshold:"
    read warn
    echo "Enter failure threshold:"
    read fail
    # Only update if numbers
    if [[ "$warn" =~ ^[0-9]+$ ]] && [[ "$fail" =~ ^[0-9]+$ ]]; then
        sed -i "s/75/$warn/" "$PROJECT/Helpers/config.json"
        sed -i "s/50/$fail/" "$PROJECT/Helpers/config.json"
        echo "Thresholds updated."
    else
        echo "Invalid input. Using defaults."
    fi
fi

# 6. Check Python
if command -v python3 >/dev/null 2>&1; then
    echo "Python3 is installed."
else
    echo "WARNING: Python3 not found."
fi

echo "Project setup complete!"
