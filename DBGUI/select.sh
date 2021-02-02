#!/bin/bash
# Style the Connected Line
function db_connected() {
    db_name=$1
    typeset -i filler_length
    filler_length=(54-${#db_name})
    echo -n "| $(tput setaf 3)<$1 "
    for ((counter = 0; counter < filler_length; counter++)); do echo -n "-"; done
    echo " Connected>$(tput setaf 2) |"
}

# Form Error Message upon the Exit Code
function select_with_check() {
    if (($# == 3)); then
        (../../"$1" "$2" "$3")
    else
        (../../"$1" "$2" "$3" "$4" "$5" "$6")
    fi
    $? || echo "Error : Check the logs"
}

function sql_parse() {
    #remove SQL specific words
    sql_line=$(echo "$entry" | sed -e 's/SELECT//g' -e 's/FROM//g' -e 's/WHERE//g' | sed -e 's/select//g' -e 's/from//g' -e 's/where//g')

    #get fields. No
    fields_no=$(echo "$sql_line" | awk -F';' 'END{print NF}')

    #get table and check its existance
    table_name=$(echo "$sql_line" | awk -F';' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
    if [[ ! -f "$table_name" ]]; then echo "Error : Invalid Table Name" ; return; fi
    # [[ -f $table_name ]] || echo "Error : Invalid Table Name" && return ;

    #get the selection column and check its existance
    select_column=$(echo "$sql_line" | awk -F';' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
    select_column_field=$(awk -F'|' 'BEGIN{found=0} {if(NR==1){for(i=1;i<=NF;i++){if($i=="'$select_column'")found=i}}} END{print found}' "$table_name")
    if ((select_column_field == 0)); then echo "Error : Invalid Selected Column Name" && return; fi

    if ((fields_no == 3)); then
        # select_with_check "select_only.sh" "$select_column" "$table_name"
        echo "select $select_column from $table_name";
        return
    else
        #get the column in the WHERE condition and check its existance
        where_column=$(echo "$sql_line" | awk -F';' '{print $3}' | awk -F'=|>|<|>=|<=' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
        where_column_field=$(awk -F'|' 'BEGIN{found=0} {if(NR==1){for(i=1;i<=NF;i++){if($i=="'$where_column'")found=i}}} END{print found}' "$table_name")
        if ((where_column_field == 0)); then echo "Error : Invalid Where Column Name"; return; fi

        # get the value in the WHERE condition and check its existance
        where_value=$(echo "$sql_line" | awk -F';' '{print $3}' | awk -F'=|>|<|>=|<=' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
        where_value_exist=$(awk -F'|' 'BEGIN{found=0} {if(NR!=1){if($"'$where_column_field'"=="'$where_value'")found=1}} END{print found}' "$table_name")
        if ((where_value_exist == 0)); then echo "Error : Value does not exist"; return; fi

        where_operator=$(echo "$sql_line" | awk -F';' '{print $3}' | grep -o "[=|>|<|>=|<=]")
        [[ $where_operator =~ (=|>|<|>=|<=) ]] || echo "Error : Invalid Where Operator"; return
        # select_with_check "select_where.sh" "$select_column" "$table_name" "$where_column" "$where_operator" "$where_value"
        echo "select $select_column from $table_name where $where_column $where_operator $where_value"
        
    fi
    # ^(\+|-|\*|/|=|>|<|>=|<=|&|\||%|!|\^|\(|\))$
    # (\=|>|<|>=|<=)
    # grep -o  "[=|>|<|>=|<=]""
    # echo "hell = no" | awk -F'=|>|<|>=|<=' '{print $2}'
}

clear
db_name=$1
while true; do
    tput setaf 2 #change font color to Green
    echo "+---------------------------------------------------------------------+"
    db_connected $db_name
    echo "+---------------------------------------------------------------------+"
    echo "| e.g. SELECT *; FROM table;                                          |"
    echo "|      SELECT column; FROM table;                                     |"
    echo "|      SELECT column ; FROM table ; WHERE column[==,<,>,>=,<=]value ; |"
    echo "|      SELECT * ; FROM table ; WHERE column[==,<,>,>=,<=]value ;      |"
    echo "|      SELECT column; FROM table;                                     |"
    echo "|      SELECT *; FROM table;                                          |"
    echo "+---------------------------------------------------------------------+"
    echo "| 1 -  Back to DB Menu                                                |"
    echo "| 2 -  Back to Main Menu                                              |"
    echo "+---------------------------------------------------------------------+"
    tput setaf 4 #change font color to blue
    read -p "$(tput setaf 3)Enter SQL Statement : " entry
    case $entry in
    1) exit ;;
    2) exit 2 ;;
    *) sql_parse ;;
    esac
done
