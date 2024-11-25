#!/bin/bash
#
# Backup script for docker minecraft server 
#
BACKUP_LOC=/mnt/backups/backups/minecraft-backups
# Message alerts server of the backup starting 
docker exec -it minecraft-server rcon-cli say "SYSTEM: Backup of the server will occur here shortly"

# Stop docker compose service & Put server message on server about the backup
docker compose down 
if [ $? -eq 0 ]; then  # the "$?" receives the exit code from the last run command , 0 = success , anything else = fail 
    echo "Compose was stopped successfully "
    # Backup severs data file  
    tar czvf $BACKUP_LOC/minecraft-backup-$(date +"%Y-%m-%d_%H-%M-%S") ./data/
    echo "$BACKUP_LOC/minecraft-backup-$(date +"%Y-%m-%d_%H-%M-%S") ./data/"
else
    echo "Compose was unable to be stopped."
    exit 1
fi


docker compose up -d 
