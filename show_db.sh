#!/bin/bash

ls DBMS > DB
zenity --width=800 --height=600 \
     --title "Databases" \
     --text-info --filename="DB"
if [ $? -eq 0 ]
then
    . DBMS.sh
fi
