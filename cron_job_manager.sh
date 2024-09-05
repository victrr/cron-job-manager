#!/bin/bash
# Filename: cron_job_manager.sh
# Cron Job Manager Script
# Version: 1.0
# Author: Victor Arredondo
# Date: 2024-09-05
# Description: A simple bash script to manage cron jobs (list, add, edit, delete, view logs).
# License: MIT License

# Function to list current cron jobs
list_cron_jobs() {
    echo "Current cron jobs:"
    # List cron jobs excluding comments, starting numbering from 1
    crontab -l | grep -v '^#' | nl -v 1
    read -p "Press [Enter] to return to the main menu..."
}

# Function to add a new cron job
add_cron_job() {
    echo "To add a new cron job, you need to provide two things:"
    echo "1. The command you want to execute."
    echo "2. The frequency in cron format."

    echo "Cron format is used to define when a task should run and has the following structure:"
    echo "  * * * * *"
    echo "  | | | | |"
    echo "  | | | | +----- Day of the week (0 - 7) (Sunday is 0 or 7)"
    echo "  | | | +------- Month (1 - 12)"
    echo "  | | +--------- Day of the month (1 - 31)"
    echo "  | +----------- Hour (0 - 23)"
    echo "  +------------- Minute (0 - 59)"
    echo ""
    echo "Cron format examples:"
    echo "  - '*/5 * * * *'    -> Every 5 minutes"
    echo "  - '0 * * * *'      -> Every hour at minute 0"
    echo "  - '0 0 * * *'      -> Daily at midnight"
    echo "  - '0 2 * * 1'      -> Weekly on Mondays at 2 AM"
    echo "  - '0 0 1 * *'      -> Monthly on the 1st at midnight"
    echo "  - '0 0 1 1 *'      -> Annually on January 1st at midnight"

    # Prompt for the command
    read -p "Enter the command you want to execute (e.g., '/home/pi/scripts/backup.sh'): " command

    # Prompt for the cron timing format
    read -p "Enter the frequency in cron format (e.g., '*/5 * * * *'): " frequency

    # Add the new cron job
    (crontab -l ; echo "$frequency $command") | crontab -
    echo "Job added: $frequency $command"
    # List cron jobs after deletion
    list_cron_jobs
}

# Function to edit an existing cron job
edit_cron_job() {
    crontab -l > current_cron

    # List the cron jobs with line numbers starting from 1
    echo "Current cron jobs:"
    grep -v '^#' current_cron | nl -v 1
    echo ""

    read -p "Enter the number of the job you want to edit: " job_number

    # Verify that the selected job number is valid
    total_jobs=$(grep -v '^#' current_cron | wc -l)
    if ! [[ "$job_number" =~ ^[0-9]+$ ]] || [ "$job_number" -lt 1 ] || [ "$job_number" -gt "$total_jobs" ]; then
        echo "Invalid job number."
        rm current_cron
        read -p "Press [Enter] to return to the main menu..."
        return
    fi

    # Extract the selected job (line number is adjusted here)
    job_line=$(grep -v '^#' current_cron | sed -n "${job_number}p")

    # Display the selected job
    echo "Selected job to edit: $job_line"
    
    # Prompt for new cron job details
    read -p "Enter the new frequency in cron format (e.g., '*/5 * * * *'): " new_frequency
    read -p "Enter the new command (e.g., '/home/vctr/tmp/disk_usage.sh'): " new_command

    # Remove the selected job from the list and replace it with the new job
    grep -v '^#' current_cron | sed "${job_number}d" > updated_cron
    echo "$new_frequency $new_command" >> updated_cron

    # Update the crontab with the new cron jobs
    crontab updated_cron
    rm current_cron updated_cron

    echo "Job updated: $new_frequency $new_command"
    # List cron jobs after deletion
    list_cron_jobs
}

# Function to delete a cron job
delete_cron_job() {
    crontab -l > current_cron
    echo "Current cron jobs:"
    grep -v '^#' current_cron | nl -v 1
    echo ""

    read -p "Enter the number of the job you want to delete: " job_number

    # Verify that the selected job number is valid
    total_jobs=$(grep -v '^#' current_cron | wc -l)
    if ! [[ "$job_number" =~ ^[0-9]+$ ]] || [ "$job_number" -lt 1 ] || [ "$job_number" -gt "$total_jobs" ]; then
        echo "Invalid job number."
        rm current_cron
        read -p "Press [Enter] to return to the main menu..."
        return
    fi

    # Remove the selected job from the list
    grep -v '^#' current_cron | sed "${job_number}d" > updated_cron

    # Update the crontab with the new cron jobs
    crontab updated_cron
    rm current_cron updated_cron
    echo "Job deleted."
    # List cron jobs after deletion
    list_cron_jobs
}

# Function to display cron job logs
show_cron_log() {
    echo "Cron job logs:"
    grep CRON /var/log/syslog
    read -p "Press [Enter] to return to the main menu..."
}

# Main menu
while true; do
    echo "========================"
    echo "1. List cron jobs"
    echo "2. Add new cron job"
    echo "3. Edit cron job"
    echo "4. Delete cron job"
    echo "5. View cron job logs"
    echo "6. Exit"
    echo "========================"
    read -p "Select an option: " choice
    case $choice in
        1) list_cron_jobs ;;
        2) add_cron_job ;;
        3) edit_cron_job ;;
        4) delete_cron_job ;;
        5) show_cron_log ;;
        6) exit ;;
        *) echo "Invalid option" ;;
    esac
done
