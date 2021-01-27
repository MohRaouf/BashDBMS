#!/bin/bash
# Style the Connected Line
function db_connected {
    db_name=$1;
    typeset -i filler_length
    filler_length=(12-${#db_name})
    echo -n "| $(tput setaf 3)<$1 "
    for (( counter=0; counter<filler_length; counter++ ))
    do echo -n "-"; done
    echo " Connected>$(tput setaf 2) |"
}

# Form Error Message upon the Exit Code
function update_with_check {
    (../../update.sh )
    result=$?
    if ((result==1)); then echo "Invalid Table Name"; 
    elif ((result==2)); then echo "Invalid Column Name";
    elif ((result==3)); then echo "No Value Found"; 
    elif ((result==4)); then echo "Invalid Value Type"; 
    else echo "Updated Successfully"; fi
}
function delete_with_check {
    (../../Delete_from.sh )
    result=$?
    if ((result==1)); then  echo " Value Not Exist ";
    elif ((result==2)); then echo " Column Attribute Not Exist";
    elif ((result==3)); then echo "Table Not Exist";
    else echo "Row Deleted Successfully"; fi
}
function insert_with_check {
    (../../insert_into.sh )
    result=$?
    if ((result==1)); then  echo " Table Not Exist ";
#    elif ((result==2)); then echo " Invalid Input Data Type";
    else echo "Row Inserted Successfully"; fi
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
	3) . ../../drop_tb.sh;;
        4) insert_with_check;;
        5) exit;;
        6) delete_with_check;;
        7) update_with_check ;;
        8) exit;;
        *) echo -e "\n______ Invalid Choice ______\n";;
    esac
done

