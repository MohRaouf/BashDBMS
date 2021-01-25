#! /bin/bash
read -p "Enter Table Name To Be Deleted: " name
if [ -f DBs/$name ]
then 
	echo "Are You Sure You Want To Delete $name Table?"
	read choice
	case $choice in
		[yY]*) rm $name $.name
			echo "Table Deleted Successfully" ;;

		[nN]*) echo "Canceled";;
		*) echo "Invalid Option";;
	esac
else
	echo "$name Table Not Exist"
fi



		

