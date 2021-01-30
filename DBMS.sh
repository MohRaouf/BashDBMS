#!/bin/bash

ListType=$(zenity --list --width=1000 --height=500   \
     --title 'Welcome to our Bash DBMS Written By: AMAAL & RAOUF'  \
     --text 'Select the Database option:' \
     --column='Main Database menu' \
      "1- Create Database" \
      "2- List Databases" \
      "3- Connect Database" \
      "4- Drop Database" \
)
case $ListType in
     "1- Create Database")  . ./create_db.sh ;;
     "2- List Databases" ) . ./show_db.sh ;;
     "3- Connect Database") . ./connect_db.sh ;;
     "4- Drop Database") . ./drop_db.sh ;;
esac
