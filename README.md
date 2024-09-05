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

