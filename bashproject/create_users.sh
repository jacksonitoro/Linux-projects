#!/bin/bash


echo "Hello Users!"

LOG_FILE="/var/log/user_management.log"


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 users.csv"
    exit 1
fi

csv_file="$1"

echo "CSV file provided: $csv_file" | tee -a "$LOG_FILE"


if [ ! -f "$csv_file" ]; then
    echo "Error: File $csv_file not found" | tee -a "$LOG_FILE"
    exit 1
fi

while IFS="," read -r username groupname
  do
    
    if [[ -z "$username" || -z "$groupname" ]]; then
	continue
    fi

    if ! getent group "$groupname" > /dev/null; then
        groupadd "$groupname"
	echo "Group $groupname created." | tee -a "$LOG_FILE"
    fi

    if ! id "$username" &>/dev/null; then
	useradd -m -g "$groupname" -s /bin/bash "$username"
	echo "User $username created and assigned to group $groupname." | tee -a "$LOG_FILE"

	password="${username}10"
	echo "$username:$password" | sudo chpasswd
	echo "Password set for user $username." | tee -a "$LOG_FILE"


	chmod 700 "/home/$username"
	chown "$username:$groupname" "/home/$username"
	echo "Home directory permission set for $username." | tee -a "$LOG_FILE"
    else
	echo "$username already exist. Skip" | tee -a "$LOG_FILE"
    fi

done < "$csv_file"

echo "User creation process completed. Check $LOG_FILE for  details."





