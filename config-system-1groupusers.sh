#!/bin/bash
# System Configuration from scratch Debian Linux
# GROUP USERS
# by Haiyong Zheng <zhenghaiyong@gmail.com>
# ##### WuZiDing #####

## VARIABLES
GROUP="huizhi"
USERS="zhenghaiyong shizhensheng guozonghui zhanghanqing wangshengbo wubin"
##

echo "===== Checking group ====="
awk -F: '{print $1}' /etc/group | grep -w $GROUP >/dev/null 2>&1
if [ $? -eq 0 ]
then
	echo "Group '$GROUP' is already exist."
else
	echo "Adding group '$GROUP' ..."
	groupadd $GROUP
fi
echo "===== Checking users ====="
for user in $USERS
do
	awk -F: '{print $1}' /etc/passwd | grep -w $user >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo "User '$user' is already exist."
	else
		echo "Adding '$user' ..."
		useradd -d /home/$user -m -g $GROUP -s /bin/bash $user
		echo $user:$user | chpasswd
	fi
done

echo "===== WELL DONE! ====="
