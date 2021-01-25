#!/bin/bash
echo -n "Enter Table Name : "
read table_name

touch "$table_name" 2>> ../../error.log  || echo "Failed" 
touch ".$table_name" 2>> ../../error.log  || echo "Failed" 

echo -n "Enter Columns Number : "
read col_count

has_pk=0
for (( counter=1; counter <= col_count; counter++ ))
do
    table_fields=""
    table_headers=""
    
    echo -n "Column[$counter] Name : ";
    read column_name
    table_headers+="$column_name"
    table_fields+="$column_name"

    echo  "Column $column_name Type ?"
    echo "1) int"
    echo "2) txt"
    echo -n "Choice : "
    read type
    case $type in 
        1 ) table_fields+="|int";;
        2 ) table_fields+="|txt";;
    esac 

    if ((has_pk==0))
    then
        echo  "Primary Key ?"
        echo "1) Yes"
        echo "2) No"
        echo -n "Choice : "
        read type
        case $type in 
            1 ) table_fields+="|pk"; has_pk=1;;
            2 ) ;;
        esac 
    fi

    echo $table_fields >> ".$table_name"
    [ -s "$table_name" ] && 
    echo "$(<${table_name})|$column_name" > "$table_name" ||
    echo "$column_name" > "$table_name"
done