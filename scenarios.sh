#!/bin/bash

echo "Choose a scenario:"
echo "1) Scenario 1 - Directory Creation"
echo "2) Scenario 2 - Extracting Information"
echo "3) Scenario 3 - Searching and Linking Files"

read choice

case $choice in
  1)
    echo "Creating Scenario 1..."
    mkdir -p ~/scenario1/grade_directory
    mkdir -p ~/scenario1/profile_directory
    echo "Math: A" > ~/scenario1/grade_directory/grades.txt
    echo "Name: Dana" > ~/scenario1/profile_directory/profile.txt
    echo "Scenario 1 created in ~/scenario1"
    ;;
    
  2)
    echo "Creating Scenario 2..."
    mkdir -p ~/scenario2
    echo "Name Cohort Grade GPA" > ~/scenario2/student_data.txt
    echo "Scenario 2 created in ~/scenario2"
    ;;
    
  3)
    echo "Creating Scenario 3..."
    mkdir -p ~/scenario3/source
    mkdir -p ~/scenario3/target
    ln -s ~/scenario3/source ~/scenario3/target/link_to_source
    echo "Scenario 3 created in ~/scenario3"
    ;;
    
  *)
    echo "Invalid choice"
    ;;
esac
