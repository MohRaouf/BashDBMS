#!/bin/bash
read -p "Enter Table Name To Be Deleted: " name
if [ -f $name ]
then 
	read -p "Are You Sure You Want To Delete $name Table ? (Y/N) : " choice
	case $choice in
		[yY]*) rm $name .$name; echo "Table Deleted Successfully" ;;
		[nN]*) echo "Canceled";;
		*) echo "Invalid Option";;
	esac
else
	echo "$name Table Not Exist"
fi



		

