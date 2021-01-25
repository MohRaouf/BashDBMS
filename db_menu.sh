#!/bin/bash
##
# Style the Connected Line
##
function db_connected {
    db_name=$1;
    typeset -i filler_length
    filler_length=(12-${#db_name})
    echo -n "| $(tput setaf 3)<$1 "
    for (( counter=0; counter<filler_length; counter++ ))
    do echo -n "-"; done
    echo " Connected>$(tput setaf 2) |"
}

clear
db_name=$1;
while true;
do
    tput setaf 2; #change font color to Green
    echo "+---------------------------+"
    db_connected $db_name
    echo "+---------------------------+"
    echo "| 1 - Create Table          |"
    echo "| 2 - List Tables           |"
    echo "| 3 - Drop Table            |"
    echo "| 4 - Insert into Table     |"
    echo "| 5 - Select From Table     |"
    echo "| 6 - Delete From Table     |"
    echo "| 7 - Update Table          |"
    echo "| 8 - Back to Main Menu     |"
    echo "+---------------------------+"
    tput setaf 4; #change font color to blue
    echo  -n "$(tput setaf 3)Choice : "
    read selection
    case $selection in
        1)  . ../../create_table.sh ;;
        2) ls ;;
        3) . ./connect_db.sh ;;
        4) . ./drop_db.sh ;;
        5) exit;;
        6) exit;;
        7) exit;;
        8) exit;;
        *) echo -e "\n______ Invalid Choice ______\n";;
    esac
done

