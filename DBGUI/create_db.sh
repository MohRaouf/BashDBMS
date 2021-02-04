#!/bin/bash
createDb=$(zenity --entry --width=500 --height=200   --ok-label="Create" --cancel-label="Exit"\
        --title "created New Database" \
        --text "Enter the Database name?" \
         --entry-text "NewDatabase" \
)
status=$?
if [ $status -eq 1 ]
     then
       exit;
else
     case $createDb in
       "NewProfile") zenity --warning  --width=400 --height=200 --title="Using DBMS Engin Status"  --ok-label="Back" --text="You Must Enter Database Name"

       if [[ $? -eq 0 ]]
       then
         . DBMS.sh
       else
         exit;
       fi ;;

       *)
       if [ -d DBMS/$createDb ]
       then
         zenity --error --width=300  --ok-label="Back" --title="Create Database Status" --text="$createDb Database already exist"
         if [ $? -eq 0 ]
         then
           . DBMS.sh
         fi
       else
         mkdir -p  DBMS/$createDb
         sucess=$(zenity --info --width=300  --ok-label="Back" --title="Create Database Status" --text="$createDb Database Created Successfully")
         if [ $? -eq 0 ]
         then
           . DBMS.sh
         fi
       fi
       ;;


     esac
fi
