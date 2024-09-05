# cron-job-manager

A simple bash script to manage cron jobs (list, add, edit, delete, view logs).

## Features

- **List current cron jobs**: Easily view all active cron jobs.
- **Add new cron jobs**: Specify the command and frequency in cron format.
- **Edit existing cron jobs**: Modify existing cron jobs with new commands and timings.
- **Delete cron jobs**: Remove cron jobs by selecting the job number.
- **View cron logs**: Check the execution logs of cron jobs from `/var/log/syslog`.

## Requirements

- Bash (default on most Linux systems)
- `crontab` command installed (commonly available on most UNIX-like systems)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/tu-usuario/cron-job-manager.git
   cd cron-job-manager

2. Make the script executable:
   ```bash
   chmod +x cron_job_manager.sh
4. Run the script:
   ```bash
   ./cron_job_manager.sh

## Usage
- **Once the script is running, you will be presented with a menu:

      ========================
      1. List cron jobs
      2. Add new cron job
      3. Edit cron job
      4. Delete cron job
      5. View cron job logs
      6. Exit
      ========================

### Adding a New Cron Job

To add a new cron job, you will need to provide:
1. The command you want to execute.
2. The schedule in cron format. For example:
   - `*/5 * * * *` → Every 5 minutes
   - `0 2 * * 1` → Every Monday at 2 AM

Example of adding a cron job:
Enter the command you want to execute (e.g., '/home/user/backup.sh'):       

      Enter the command you want to execute (e.g., '/home/user/backup.sh'): /path/to/script.sh
      Enter the frequency in cron format (e.g., '*/5 * * * *'): */10 * * * *


### Editing or Deleting a Cron Job

You will be asked to select a job by its number from the list of current cron jobs. From there, you can either modify or remove the job as needed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- **Victor Arredondo**

## Script Details

### Filename: cron_job_manager.sh
### Version: 1.0
### Date: 2024-09-05
### Description: A simple bash script to manage cron jobs (list, add, edit, delete, view logs).
### License: MIT License
