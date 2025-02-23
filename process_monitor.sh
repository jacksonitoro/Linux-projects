#!/bin/bash
#To monitor firefox browser

PROCESS_NAME="firefox"
LOG_FILE="/home/jackson/process_monitor.log"

check_process() {
    if pgrep -x "$PROCESS_NAME" > /dev/null; then
	echo "$(date): $PROCESS_NAME is running." | tee -a "$LOG_FILE"
    else
	echo "$(date): $PROCESS_NAME is not running!" | tee -a "$LOG_FILE"
    fi
}

check_process
 

