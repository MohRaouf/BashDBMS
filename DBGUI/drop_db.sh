#!/bin/bash

#
# read -p  "Enter Database Name : " name
# if [ -d DBMS/$name ]
# then
#         read -p "Are you sure You Want To Delete $name ? (Y/N) : " choice
#         case $choice in
#                 [yY]*) rm -r DBMS/$name; echo "$name Deleted Successfully";;
#                 [nN]*) echo " Operation Canceled";;
#                 *) echo "Invalid option";;
#         esac
# else
#         echo "$name Database Not Exist"
# fi
#
# if [ $? -eq 0 ]
# then
#     . DBMS.sh
# fi

name=$(zenity --entry --width=500 --height=200 --ok-label="Delete" --cancel-label="Exit"\
        --title "Drop Database" \
        --text "Enter the Database name?" \
)
if [[ $? -eq 1 ]]
then exit;
  # zenity --error --width=300  --title="Connect to Database Status" --text="you must enter DB"
elif [[ -d DBMS/$name ]]
then
 rm -r DBMS/$name;
 zenity --info --width=300  --ok-label="Back" --title="Drop Database Status" --text="$name Database Droped Successfully"
 if [ $? -eq 0 ]
 then
   . DBMS.sh
 fi
else
  zenity --error --width=300  --ok-label="Back"  --title="Drop Database Status" --text="$name Database Not Exist"
  if [ $? -eq 0 ]
  then
    . DBMS.sh
  fi
fi
