#!/bin/bash
cd ../..
ls DBMS/$1 > TB
zenity --width=800 --height=600 --ok-label="Back" \
     --title "Tables in $1 Batabase" \
     --text-info --filename="TB"
cd DBMS/$1
if [ $? -eq 0 ]
then
    . ../../db_menu.sh
fi
