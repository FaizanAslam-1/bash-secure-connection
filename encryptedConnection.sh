#!/bin/bash

if ! command -v ncat &> /dev/null; then
	echo "Ncat is not installed. Installing now ... \n"
	sudo apt-get update && sudo apt install ncat -y  
		if ! command -v ncat &> /dev/null; then
			echo "Failed to install ncat. Exiting ... \n"
			exit 1
		fi
fi

echo -e -n " Enter 1 to send connection \n Enter 2 to receive connection \n Enter anything other than 1 and 2 to exit : " 
read opt

if [ "$opt" = "1" ]; then 
	echo -e "\n"
	echo -n "Your IP : " 
	ifconfig | grep "inet " | awk '{print $2}' | grep -v "127.0.0.1" 
	echo -e "\n"
	read -p "Enter the port same as receiver , on which you want to create connection : " port
	echo -e "Trying to create connection ... \n"
	ncat --ssl -lvnp "$port"
	echo -e "\n"
	echo -e "Connection is closed \n"
	
elif [ "$opt" = "2" ]; then 
	echo -e "\n"
	read -p "Enter IP of sender : " senderIP
	read -p "Enter the port same as sender , on which you want to create connection : " port
	echo -e "Trying to create connection ... \n"
	ncat --ssl "$senderIP" "$port"
	echo -e "\n"
	echo -e "Connection is closed \n"	
else
	echo "Exiting ... "
	exit 0 

fi
