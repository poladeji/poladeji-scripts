#script_name
#read schema_name
#cp .ssh/id_rsa.pub .ssh/id_rsa.pub.`hostname`

#username=`whoami`
echo "remote_username"
read remote_username
username=$remote_username
echo "remote_machine"
read remote_machine

##username=$0
##remote_machine=$1

[ ! -f .ssh/id_rsa.pub ] && ssh-keygen -t rsa;
ssh-copy-id $username@$remote_machine
ssh $username@$remote_machine "chmod 700 .ssh; chmod 600 .ssh/authorized_keys"
ssh $username@$remote_machine "chmod 700 /home/$username"
#ssh $username@$remote_machine 'chmod 644 .ssh/authorized_keys'

