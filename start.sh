#! bin/bash
Welcom=$(zenity --list --width=1000 --height=500 --radiolist --ok-label="Go" --cancel-label="Exit" \
     --title 'Welcome to our Bash DBMS Engin Written By: AMAAL & RAOUF'  \
     --text 'Select option For Using DB Engine:' \
     --column='options' \
     --column="Database Engine" \
     "_" "By Using GUI" \
     "_" "By Using SQL Statement"
     )
if [ $? -eq 1 ]
     then
       exit;
else
     case $Welcom in
       "By Using GUI") cd DBGUI; ./DBMS.sh ;;
       "By Using SQL Statement" ) cd DBMS; ./DBMS.sh ;;
       *)zenity --warning  --width=400 --height=200 --title="Using DBMS Engin Status"  --ok-label="Back" --text="You Must Choose An Option"
       if [ $? -eq 0 ]
       then
         . wlecom.sh
       fi
     esac
fi
