#!/bin/bash
# System Configuration from scratch Linux
# SUDO
# by Haiyong Zheng <zhenghaiyong@gmail.com>
# ##### WuZiDing #####

## VARIABLES
USERS="zhenghaiyong shizhensheng guozonghui zhanghanqing wangshengbo wubin"
SUDOERS="/etc/sudoers"
SUDOERSDIR="/etc/sudoers.d"
INCLUDEDIR="#includedir /etc/sudoers.d"
##

echo "===== Checking sudo ====="
if [ -f /etc/sudoers ]
then
	echo "sudo is already installed."
else
	echo "Installing sudo ..."
	apt-get update
	apt-get install sudo
fi

echo "===== Checking sudo '#include' ====="
cat $SUDOERS | grep "$INCLUDEDIR" >/dev/null 2>&1
if [ $? -eq 0 ]
then
	echo "sudo has '$INCLUDEDIR' configurated."
else
	echo "Configurating '$SUDOERS' by adding '$INCLUDEDIR' ..."
	chmod +w $SUDOERS
	echo "" >> $SUDOERS
	echo $INCLUDEDIR >> $SUDOERS
	chmod -w $SUDOERS
fi

echo "===== Configurating sudo users ====="
for user in $USERS
do
	echo "Adding file $SUDOERSDIR/$user ..."
	echo "$user	ALL=(ALL:ALL) ALL" > $SUDOERSDIR/$user
done

echo "===== WELL DONE! ====="
