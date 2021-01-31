#!/bin/bash
col_format=' _ name type _ '
function col_data () {
  # IFS=$'\n'
  for (( counter=1; counter <= col_num; counter++ ))
  do
          echo $col_format
  done
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
      ListType=$(zenity --list --width=1000 --height=500  --ok-label="Add Columns" --cancel-label="Exit" --editable --multiple  --separator="|" --checklist --print-column="ALL" \
           --title "column details"  \
           --text 'Enter the field options:' \
           --column="select" \
           --column="Field Name" \
           --column="Data Type (txt/int)" \
           --column="Primary Key(pk)" \
            $(col_data)
      )
        awk -v RS='[|\n]' ''{a=$0;getline b; getline c; print a,b,c}' OFS=| ' <<<$ListType > "$table_name"

      # awk 'BEGIN{FS="|" ; line="'$col_num'" ; count=0}{while(count<"'$col_num'"){for(i=1;i<4;i++){print $i} NR=count ;count+=1;print $0} }' <<<$ListType > "$table_name"
      # for((i=0;i <= col_num;i++))
      #  do
      #  sed 's/|/\n/3;p;d' <<<$ListType > "$table_name"
      #  done

    fi

          ;;
    1)
    zenity --error --width=300   --ok-label="Back"  --title="Create Database Status" --text="you must add table"

        ;;
    -1)
        echo "An unexpected error has occurred."
	       ;;
esac



# echo -n "Enter Columns Number : "
# read col_count
#
# has_pk=0
# for (( counter=1; counter <= col_count; counter++ ))
# do
#     table_fields=""
#     table_headers=""
#
#     echo -n "Column[$counter] Name : ";
#     read column_name
#     table_headers+="$column_name"
#     table_fields+="$column_name"
#
#     echo  "Column $column_name Type ?"
#     echo "1) int"
#     echo "2) txt"
#     echo -n "Choice : "
#     read type
#     case $type in
#         1 ) table_fields+="|int";;
#         2 ) table_fields+="|txt";;
#     esac
#
#     if ((has_pk==0))
#     then
#         echo  "Primary Key ?"
#         echo "1) Yes"
#         echo "2) No"
#         echo -n "Choice : "
#         read type
#         case $type in
#             1 ) table_fields+="|pk"; has_pk=1;;
#             2 ) ;;
#         esac
#     fi
#
#     echo $table_fields >> ".$table_name"
#     [ -s "$table_name" ] &&
#     echo "$(<${table_name})|$column_name" > "$table_name" ||
#     echo "$column_name" > "$table_name"
# done
# zenity --width=800 --height=600 --checkbox=Save \
#      --title "'$table_name' Table" \
#      --text-info --filename="'$table_name'" \
