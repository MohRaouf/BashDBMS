#!/bin/bash
ListType=$(zenity --list --width=1000 --height=500  --ok-label="Select" --cancel-label="Exit"  \
     --title 'Welcome to our Bash DBMS GUI'  \
     --text 'Select the Database option:' \
     --column='Main Database menu' \
      "1- Create Database" \
      "2- List Databases" \
      "3- Connect Database" \
      "4- Drop Database" \
)

if [ $? -eq 1 ]
     then
       exit;
else
  case $ListType in
       "1- Create Database")  . ./create_db.sh ;;
       "2- List Databases" ) . ./show_db.sh ;;
       "3- Connect Database") . ./connect_db.sh ;;
       "4- Drop Database") . ./drop_db.sh ;;
       *)zenity --warning  --width=400 --height=200 --title="Main Database menu Status"  --ok-label="Back" --text="You Must Choose An Option"
       if [ $? -eq 0 ]
       then
         . DBMS.sh
       fi
     esac
fi
