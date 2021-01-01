#!/bin/bash
# ==============================
# =   Database Backup Script   =
# =         By: Vesk0          =
# ==============================

BACKUP_DIR="/root/db-backups" # The direcotory where the backups will be saved
DB="database1" # Database name

# Make the directory
mkdir -p $BACKUP_DIR
chmod 777 $BACKUP_DIR

# Date
SERIAL="`date +%Y%m%d-%H%M%S`"
 
# Backup function
function DoBackup
{
echo "Starting backup..."
 
DBFILE=$BACKUP_DIR/$DB-$SERIAL.sql
if [ -a  $DBFILE ]
then
mv $DBFILE $DBFILE.`date '+%M%S'`
fi
echo "Dumping $DB..."
mysqldump -B --databases $DB >> ${DBFILE}
echo "Done!"
}


# Adding cron job
function insert_cronjob {
  echo "* Installing cronjob.. "

  crontab -l | { cat; echo "0 4 * * * /direcotry/to/the/script.sh"; } | crontab -   # You need to change the script directory to yours. Currently it is set to backup at 4 AM. You can generate you gron here: https://crontab.guru/ 

  echo "* Cronjob installed!"
}
 

DoBackup
insert_cronjob
echo "All backups Completed"
# EOF
