#!/bin/bash

echo "Setting root password"
PASS=$CONTAINER_ROOT_PASS
echo "root:$PASS" | chpasswd

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this container via SSH using:"
echo ""
echo "    ssh -p <port> root@<host>"
echo "and enter the root password '$PASS' when prompted"
echo ""
echo "========================================================================"

echo "Configuring ssmtp"
sed -i "s/AuthUser=.*/AuthUser=$SSMTP_AUTHUSER/g" /etc/ssmtp/ssmtp.conf
sed -i "s/AuthPass=.*/AuthPass=$SSMTP_AUTHPASS/g" /etc/ssmtp/ssmtp.conf
sed -i "s/mailhub=.*/mailhub=$SSMTP_MAILHUB/g" /etc/ssmtp/ssmtp.conf
echo "=> Done!"


exec supervisord -n
