#!/bin/bash

NC='\033[0m'
Blue='\033[1;34m'
Cyan='\033[0;31m'
Purple='\033[1;35m'
Green="\033[0;32m"

#read "please enter the name of the file whith the list of the users: " userslist
echo "please enter the name of the file whith the list of the users: "
read userslist
userslist='users.txt'

#	mv /etc/subgid.lock /etc/subgid.lock2
#	mv /etc/subgid /etc/subgid2

for line in $(cat $userslist)
do
	userN=`echo $line | cut -d : -f1`
	groupN=`echo $line | cut -d : -f2`
	passN=`echo $line | cut -d : -f3`
	passNSsl=`openssl passwd -crypt $password`
	shellN=`echo $line | cut -d : -f4`
	echo $userN" | "$groupN" | "$passN" | "$shellN
done

echo "Home directories: " ;ls /home
echo "-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
	userN=`echo $line | cut -d : -f1`
	groupN=`echo $line | cut -d : -f2`
	passN=`echo $line | cut -d : -f3`
	passNSsl=`openssl passwd -crypt $passN`
	shellN=`echo $line | cut -d : -f4`
cat /etc/passwd
echo -e "$Purple Proceed further? $NC"
read further

for line in $(cat $userslist)
do
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	userN=`echo $line | cut -d : -f1`

	if [[ `grep "$userN" /etc/passwd` ]]
	then
		if [[ $userN!="root" ]]
			then		
				userdel -f $userN
				echo "user $userN deleted"
			else
				echo "user $userN present as root in system"
		fi
	else
		echo "user $userN is absent"					
	fi
	echo "group-----group-----group-----group-----group-----group-----group-----"
	groupN=`echo $line | cut -d : -f2`
	echo "$groupN= "$groupN
	echo '$(grep $groupN: /etc/passwd)= ' $(grep $groupN':' /etc/passwd)
	echo "group-----group-----group-----group-----group-----group-----group-----"
	if [[ $(grep $groupN":" /etc/passwd) ]]
	then
		groupdel -f $groupN
		echo "group $groupN deleted"
	else
		echo "group $groupN is absent"	
	fi
echo "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
	echo "userN: "$userN
echo "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu"	
done
echo "------------------------------------------------------"
for line in $(cat $userslist)
do
	userN=`echo $line | cut -d : -f1`
	groupN=`echo $line | cut -d : -f2`
	passN=`echo $line | cut -d : -f3`
	passNSsl=`openssl passwd -crypt $passN`
	shellN=`echo $line | cut -d : -f4`
	
	useradd $userN
	usermod -s $shellN $userN
	usermod -p $passNSsl $userN
#	echo -e "$Purple $username password is changed $NC"
	
	groupadd $groupN
	
	gpasswd -a $userN $groupN
	usermod -G $groupN $userN
done
cat /etc/passwd

echo -e "$Green user+++++++++++++groupuser+++++++++++++groupuser+++++++++++++group $NC"
for line  in $(cat $userslist)
do 
	userN=`echo $line | cut -d : -f1`
	echo -e "$Cyan $userN groups : $NC"; id $userN
done
echo "user+group=====user+group=====user+group=====user+group====="
echo "---------------------------------------------------"
echo -e "$Green user++++pass+++user++++passuser++++passuser++++pass $NC"
for line  in $(cat $userslist)
do 
	userN=`echo $line | cut -d : -f1`
	userPass=`grep $userN /etc/shadow`
	echo -e "$Purple $userN  password:  $NC $userPass"
done
echo "user=====pass=====user=====pass=====user=====pass=====user=====pass"
echo "---------------------------------------------------"
echo -e "$Green user++++bin/bash+++user++++bin/bash+++user++++bin/bash+++user++++ $NC"
for line  in $(cat $userslist)
do 
	userN=`echo $line | cut -d : -f1`
	userShell=`grep $userN /etc/passwd`
	
	echo -e "$Blue $userN  /bin/bash/shell:  $NC $userShell"
done
echo "user======bin/bash/shell====user======bin/bash/shell====user======"
#	mv /etc/subgid.lock2 /etc/subgid.lock
#	mv /etc/subgid2 /etc/subgid
echo '======================================================'

echo "------------------------------------------------------"
