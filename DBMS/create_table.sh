#! /bin/bash
# Style the Connected Line
function db_connected() {
    db_name=$1
    typeset -i filler_length
    filler_length=(54-${#db_name})
    echo -n "| $(tput setaf 3)<$1 "
    for ((counter = 0; counter < filler_length; counter++)); do echo -n "-"; done
    echo " Connected>$(tput setaf 2) |"
}
function create_with_check() {
    if ! [[ "$entry" =~ (^"create"|"CREATE"%) ]]; then echo "Invalid SQL Statement"; return; fi;  
    
     #remove SQL specific words 
    sql_line=$(echo "$entry" | sed -e 's/CREATE//g' -e 's/TABLE//g' | sed -e 's/create//g' -e 's/table//g')

    #get table and check its existance
    table_name=$(echo "$sql_line" | awk -F'(' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
    if [[ -f "$table_name" ]]; then
        echo "Error : Tabel Name Exists"
        return
    fi

    #create table files
    touch "$table_name" 2>>../../error.log || echo "Failed"
    touch ".$table_name" 2>>../../error.log || echo "Failed"

    #clean in format : column1 int pk , column2 txt
    sql_line=$(echo "$sql_line" | awk -F'(' '{print $2}' | awk -F')' '{ gsub(/^[ \t]+|[ \t]+$/, "",$1); print $1}')

    #table columns number
    table_columns_number=$(echo "$sql_line" | awk -F',' 'END{print NF}')

    has_pk=0
    table_fields=""
    table_headers=""
    #check for invalid datatype or more than one primary key
    for ((i = 1; i <= $table_columns_number; i++)); do
        column_name=$(echo "$sql_line" | awk -F',' '{print $'$i' }' | awk -F' ' '{print $1}')
        dataType=$(echo "$sql_line" | awk -F',' '{print $'$i' }' | awk -F' ' '{print $2}')
        primary_key=$(echo "$sql_line" | awk -F',' '{print $'$i' }' | awk -F' ' '{print $3}')
        if (((dataType != "txt") && (dataType != "int"))); then
            echo "Error : Invalid Data Type in Column ['$i']"
            return
        fi
        if [ "$primary_key" = "pk" ]; then
            if ((has_pk == 0)); then
                has_pk=1
            else
                echo "Error : More Than One Primary Key"
                return
            fi
        fi
        table_headers=$(echo "$table_headers" | awk -F'|' '{OFS=FS}END{$'$i'="'$column_name'"; print}')
        if [ "$primary_key" = "pk" ]; then
            table_fields="$column_name|$dataType|$primary_key"
        else table_fields="$column_name|$dataType"
        fi
        echo "$table_fields" >>".$table_name" 2>>../../error.log || echo "Failed"
    done
    echo "$table_headers" >>"$table_name"
    echo "Created Successfully"
}

clear
db_name=$1
while true; do
    tput setaf 2 #change font color to Green
    echo "+---------------------------------------------------------------------+"
    db_connected "$db_name"
    echo "+---------------------------------------------------------------------+"
    echo "| e.g. CREATE TABLE table_name (column1 int pk , column2 txt , . . )  |"
    echo "+---------------------------------------------------------------------+"
    echo "| 1 -  Back to DB Menu                                                |"
    echo "| 2 -  Back to Main Menu                                              |"
    echo "+---------------------------------------------------------------------+"
    tput setaf 4 #change font color to blue
    read -p "$(tput setaf 3)Enter SQL CREATE Statement : " entry
    case $entry in
    1) exit ;;
    2) exit 2 ;;
    *) create_with_check ;;
    esac
done
