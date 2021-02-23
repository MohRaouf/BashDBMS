#!/bin/bash

name=$(zenity --entry --width=500 --height=200 --ok-label="Connect" --cancel-label="Exit" \
        --title "Connect To Database" \
        --text "Enter the Database name?" \
)
use=$?;
if [[ $use -eq 1 ]]
then exit;
elif [[ "$use" =~ ^$ ]]
 then
  zenity --error --width=300  --title="Connect to $name Database Status" --ok-label="Exit" --text="you must enter DB"
elif [[ -d DBMS/$name ]]
then
  user=$(zenity --forms --width=500 --height=400 --ok-label="LogIn" --cancel-label="Exit" --title="LogIn Form" \
  --text "LogIn to use $name Database?" \
  --separator="|" \
  --add-entry="Username?" \
  --add-password="password" \
  )
  echo $user
  LogIn_name=`awk 'BEGIN{FS="|"}{print $1}' <<<$user`
  password=`awk 'BEGIN{FS="|"}{print $2}' <<<$user`
  founduser=$(awk 'BEGIN{FS="|";found=0}{if($1 == "'$LogIn_name'" && $2 == "'$password'"){found=1}}END{print found}' users)
  if [[ $founduser -eq 1 ]]
  then
    zenity --info --width=300  --ok-label="Use $name DB"  --title="Connect to $name Database Status" --text=" Login success !, You Are Now Connected On $name Database Successfully" ;
    cd DBMS/$name;
    . ../../db_menu.sh "$name";
  else
    zenity --error --width=300  --title="Connect to $name Database LogiIn Status" --ok-label="Back" --text="Not A User Failed To LogIn"
    if [ $? -eq 0 ]
    then
      . DBMS.sh
    fi
  fi
else
  zenity --error --width=300   --ok-label="Back" --title="Connect to $name Database Status" --text="$name Database Not Exist"
  if [ $? -eq 0 ]
  then
    . DBMS.sh
  fi
fi
