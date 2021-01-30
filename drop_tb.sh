#!/bin/bash
# read -p "Enter Table Name To Be Deleted: " name
# if [ -f $name ]
# then
# 	read -p "Are You Sure You Want To Delete $name Table ? (Y/N) : " choice
# 	case $choice in
# 		[yY]*) rm $name .$name; echo "Table Deleted Successfully" ;;
# 		[nN]*) echo "Canceled";;
# 		*) echo "Invalid Option";;
# 	esac
# else
# 	echo "$name Table Not Exist"
# fi


name=$(zenity --entry --width=500 --height=200 \
        --title "Drop $1 Tables" \
        --text "Enter the Table Name?" \
)
if [[ $? -eq 1 ]]
then exit;
  # zenity --error --width=300  --title="Connect to Database Status" --text="you must enter DB"
elif [[ -f $name ]]
then
 rm  $name .$name;
 zenity --info --width=300  --title="Drop $name Table Status" --text="$name Table Droped Successfully"
 if [ $? -eq 0 ]
 then
   . ../../db_menu.sh
 fi
else
  zenity --error --width=300  --title="Drop $name Table Status" --text="$name Table Not Exist"
  if [ $? -eq 0 ]
  then
    . ../../db_menu.sh
  fi
fi
