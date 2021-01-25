#!/bin/bash
while true;
do
tput setaf 2; #change font color to Green
echo "+---------------------------+"
echo "| $(tput setaf 3)Welcome to our Bash DBMS !$(tput setaf 2)|"
echo "| $(tput setaf 3)Written By: AMAAL & RAOUF$(tput setaf 2) |"
echo "+---------------------------+"
echo "| 1 - Create Database       |"
echo "| 2 - List Databases        |"
echo "| 3 - Connect Database      |"
echo "| 4 - Drop Database         |"
echo "| 5 - Exit                  |"
echo "+---------------------------+"
tput setaf 4; #change font color to blue
echo  -n "$(tput setaf 3)Choice : "
read choice
case $choice in
    1)  . ./create_db.sh ;;
    2) ls DBMS ;;
    3) echo "Amaal Working on it";;
    4) echo "Amaal Working on it";;
    5) Exit;;
    *) echo -e "\n______ Invalid Choice ______\n";;
esac
done