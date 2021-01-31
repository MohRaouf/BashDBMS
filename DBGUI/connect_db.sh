#! /bin/bash

name=$(zenity --entry --width=500 --height=200 --ok-label="Connect" --cancel-label="Exit" \
        --title "Connect To Database" \
        --text "Enter the Database name?" \
)
use=$?;
if [[ $use -eq 1 ]]
then exit;
elif [[ "$use" =~ ^$ ]]
 then
  zenity --error --width=300  --title="Connect to $name Database Status" --cancel-label="Exit" --text="you must enter DB"
elif [[ -d DBMS/$name ]]
then
  # username=$(zenity --entry --title Login --text="Username");
  # password=$(zenity --password --title Login);
#   result=$(mysql -s -N LibraryManagementSystem -uroot -pmysql123<<<"select count(id) from users where username='$username' and password='$password'");
#   echo $result;
#   if [ $result = 1  ]; then
# 	zenity --info \
# 	--text="Login Success";
# fi
  cd DBMS/$name;
  zenity --info --width=300  --ok-label="Use $name DB"  --title="Connect to $name Database Status" --text="$name Database Selected Successfully" ;
  . ../../db_menu.sh "$name";

else
  zenity --error --width=300   --cancel-label="Exit" --title="Connect to $name Database Status" --text="$name Database Not Exist"
  if [ $? -eq 0 ]
  then
    . DBMS.sh
  fi
fi
