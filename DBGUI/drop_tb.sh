#!/bin/bash

name=$(zenity --entry --width=500 --height=200 --ok-label="Delete" --cancel-label="Exit" \
        --title "Drop $1 Tables" \
        --text "Enter the Table Name?" \
)
if [[ $? -eq 1 ]]
then exit;
elif [[ -f $name ]]
then
 rm  $name .$name;
 zenity --info --width=300  --ok-label="Back"  --title="Drop $name Table Status" --text="$name Table Droped Successfully"
 if [ $? -eq 0 ]
 then
   . ../../db_menu.sh
 fi
else
  zenity --error --width=300  --ok-label="Back"  --title="Drop $name Table Status" --text="$name Table Not Exist"
  if [ $? -eq 0 ]
  then
    . ../../db_menu.sh
  fi
fi
