#!/bin/bash

set -e

USERNAME=$1

if [ "$USERNAME" == "" ]; then
    echo "No username specified as arugment to $0"
    exit 1
fi

echo "Setting up SSH for user $USERNAME"

SSH_DIR=/home/$USERNAME/.ssh
mkdir -p $SSH_DIR

# create keys
mv ./keys/bds $SSH_DIR/id_rsa
mv ./keys/bds.pub $SSH_DIR/id_rsa.pub
chmod 600 $SSH_DIR/id_rsa

# authorize keys
cat $SSH_DIR/id_rsa.pub >> $SSH_DIR/authorized_keys
chmod 0600 $SSH_DIR/authorized_keys

# transfer to user
chown -R $USERNAME:$USERNAME $SSH_DIR

# avoid host key verification prompt
sudo sed -i '/#   StrictHostKeyChecking ask/c\StrictHostKeyChecking no' /etc/ssh/ssh_config
