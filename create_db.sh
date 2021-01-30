#!/bin/bash
createDb=$(zenity --entry --width=500 --height=200 \
        --title "created New Database" \
        --text "Enter the Database name?" \
)


if [[ $? -eq 1 ]]
then exit;
elif [ -d ~/DBGUI/DBMS/$createDb ]
then
  zenity --error --width=300  --title="Create Database Status" --text="$createDb Database already exist"
  if [ $? -eq 0 ]
  then
    . DBMS.sh
  fi
#   zenity --error --width=300  --title="Create Database Status" --text="enter valid input"
else
  mkdir -p  DBMS/$createDb 2>>error.log
  sucess=$(zenity --info --width=300  --title="Create Database Status" --text="$createDb Database Created Successfully")
  # back=$(zenity --question --width 300 --text "Are you want to Bact to Main menu?")
  if [ $? -eq 0 ]
  then
    . DBMS.sh
  fi
fi
