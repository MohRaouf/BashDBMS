#!/bin/bash
col_format='name type NULL'
touch .Columns
function col_data () {
  for (( counter=1; counter <= col_num; counter++ ))
  do
          echo $col_format >> tmp
  done
  mv tmp .Columns
}


table=$(zenity --forms --width=500 --height=400 --ok-label="Create" --cancel-label="Exit" --title="Create New Table" \
--text "Create Table?" \
--separator="|" \
--add-entry="Enter Table  name?" \
--add-entry="Enter Number Of Columns")
case $? in
    0)
    table_name=`awk 'BEGIN{FS="|"}{print $1}' <<<$table`
    if [ -f $table_name ]
    then
      zenity --error --width=300   --ok-label="Back"  --title="Create Database Status" --text="$table_name Table already exist"
    else
      touch "$table_name"
      touch ."$table_name"
      col_num=`awk 'BEGIN{FS="|"}{print $2}' <<<$table`
      col_data;
      ListType=$(zenity --list --width=1000 --height=500  --ok-label="Add Columns" --cancel-label="Exit" --editable --multiple  --separator="|" --checklist --print-column="ALL" \
           --title "column details"  \
           --text 'Enter the field options:' \
           --column="select"\
           --column="Field Name" \
           --column="Data Type (txt/int)" \
           --column="Primary Key(pk)" \
            $(awk 'BEGIN{FS=" "}{print "TRUE\t"$0}' .Columns)
      )
      sed 's/\(\([^|]\+|\)\{3\}\)/\1\n/g;s/|\n/\n/g' <<<$ListType > ".$table_name";
      zenity --info --width=300  --ok-label="Back"  --title="$table_name Table Status" --text="$table_name Table Created Successfully"
      if [ $? -eq 0 ]
      then
        . ../../db_menu.sh
      fi
    fi ;;
    1) zenity --error --width=300   --ok-label="Back"  --title="Create Table Status" --text="You must add table";;
esac

# zenity --width=800 --height=600 --checkbox=Save \
#      --title "'$table_name' Table" \
#      --text-info --filename="'$table_name'" \
