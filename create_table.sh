#!/bin/bash
table_name=$(zenity --entry --width=500 --height=200 \
        --title "created New Table" \
        --text "Enter Table  name?" \
)
touch "$table_name" 2>> ../../error.log  || echo "Failed"
touch ".$table_name" 2>> ../../error.log  || echo "Failed"

col_Num=$(zenity --entry --width=500 --height=200 \
        --title "created New Table" \
        --text "Enter column Number?" \
)
function colLoop () {
  for ((i=0; i<'$col_Num';i++))
  do
     echo " "
  done
}

ListType=$(zenity --list --width=1000 --height=500 --editable  \
     --title "create $table_name"  \
     --text 'Select the field option:' \
     --column="Field Name"\
      --column="Data Type" \
      --column="Primary Key"\
      --print-column="Data Type"\

      $(colLoop)
)



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
zenity --width=800 --height=600 --checkbox=Save \
     --title "'$table_name' Table" \
     --text-info --filename="'$table_name'" \
