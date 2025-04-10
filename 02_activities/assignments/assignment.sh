#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

mkdir analysis output
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip

###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir data

# 2. Move the ./rawdata directory to ./data/raw
mv rawdata/ data/raw/

# 3. List the contents of the ./data/raw directory
ls data/raw/

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs
mkdir -p data/processed/server_logs data/processed/user_logs data/processed/event_logs

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs

# First I find al the files then pipe it as single argument to Copy command. xargs helps to provide source data to the copy command

find data/raw/ -name "server*.log" | xargs -I {} cp {} data/processed/server_logs
# 6. Repeat the above step for user logs and event logs
find data/raw/ -name "user*.log" | xargs -I {} cp {} data/processed/user_logs
find data/raw/ -name "event*.log" | xargs -I {} cp {} data/processed/event_logs

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
rf -rf ./data

find data/raw/ -name "*ipaddr*" | xargs rm 
find data/processed/user_logs/ -name "*ipaddr*" | xargs rm 

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed
ls -R data/processed/ | touch data/inventory.txt 

###########################################

echo "Project setup is complete!"
