#!/bin/bash

# Form Error Message upon the Exit Code
function update_with_check() {
    (../../update.sh)
    result=$?
    if ((result == 1)); then
        echo "Error : Invalid Table Name"
    elif ((result == 2)); then
        echo "Error : Invalid Column Name"
    elif ((result == 3)); then
        echo "Error : No Value Found"
    elif ((result == 4)); then
        echo "Error : Invalid Value Type"
    elif ((result == 5)); then
        echo "Error : PK Value Exists"
    else echo "Updated Successfully"; fi
}
# Form Error Message upon the Exit Code
function select_with_check() {
    (../../select.sh $1)
    result=$?
    if ((result == 1)); then
        echo "Error : Check the logs"
    elif ((result == 2)); then exit; fi
}
function delete_with_check() {
    (../../Delete_from.sh)
    result=$?
    if ((result == 1)); then
        echo " Value Not Exist "
    elif ((result == 2)); then
        echo " Column Attribute Not Exist"
    elif ((result == 3)); then
        echo "Table Not Exist"
    else echo "Row Deleted Successfully"; fi
}
function insert_with_check() {
    (../../insert_into.sh)
    result=$?
    if ((result == 1)); then
        echo " Table Not Exist "
        #    elif ((result==2)); then echo " Invalid Input Data Type";
    else echo "Row Inserted Successfully"; fi
}

db_name=$1
ListType=$(zenity --list --width=1000 --height=500  --ok-label="Select" --cancel-label="Exit"  \
     --title 'Connected To '$db_name' Database'  \
     --text 'Select Operation To Do In '$db_name' Database :' \
     --column=' '$db_name' Database Options menu' \
    "1 - Create Table" \
    "2 - List Tables" \
    "3 - Drop Table" \
    "4 - Insert into Table" \
    "5 - Select From Table" \
    "6 - Delete From Table" \
    "7 - Update Table" \
    "8 - Back To Main Menu" \
)

    if [ $? -eq 1 ]
         then
           exit;
    else
      case $ListType in
      "1 - Create Table") . ../../create_table.sh ;;
      "2 - List Tables") . ../../list_tb.sh $db_name ;;
      "3 - Drop Table") . ../../drop_tb.sh $db_name;;
      "4 - Insert into Table") insert_with_check ;;
      "5 - Select From Table") select_with_check "$db_name" ;;
      "6 - Delete From Table") delete_with_check ;;
      "7 - Update Table") update_with_check ;;
      "8 - Back To Main Menu") cd ../.. ; ./DBMS.sh;;
      *)zenity --warning  --width=400 --height=200 --title="Main Database menu Status"  --ok-label="Back" --text="You Must Choose An Option"
           if [ $? -eq 0 ]
           then
             . ../../db_menu.sh
           fi
         esac
    fi
