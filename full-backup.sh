#!/bin/bash
rm $DISK/$ORACLE_SID/$ORACLE_SID.control.txt
rm $DISK/$ORACLE_SID/init$ORACLE_SID.ora
rm $DISK/$ORACLE_SID/backup.log
>$DISK/$ORACLE_SID/backup.log
sqlplus -s /nolog <<EOF > /dev/null
   connect / as sysdba
   alter database backup controlfile to trace as '$DISK/$ORACLE_SID/$ORACLE_SID.control.txt';
   create pfile='$DISK/$ORACLE_SID/init$ORACLE_SID.ora' from spfile;
exit;
EOF

rman TARGET $SYS@$SERVICE cmdfile $SCRIPTS/backup.rman log $DISK/$ORACLE_SID/backup.log > /dev/null &
#rman TARGET $SYS@$SERVICE CATALOG $CATALOG_U@$SERVICE2 cmdfile $SCRIPTS/backup.rman log $DISK/$ORACLE_SID/backup.log > /dev/null &
exit

mailx -s "$ORACLE_SID of `hostname` Rman backup done Successfully " $MAIL <$DISK/$ORACLE_SID/backup.log

#top -b -n1 | mail -s 'Process snapshot' $MAIL
