#!/bin/bash
# UPDATE table; SET column1=value1; WHERE column2=value2;
echo -e "e.g. UPDATE table; SET column1=value1; WHERE column2=value2;"
read -p "Enter SQL Statement : " sql_line

#remove SQL specific words
sql_line=$(echo "$sql_line" | sed -e 's/UPDATE//g' -e 's/SET//g' -e 's/WHERE//g' | sed -e 's/update//g' -e 's/set//g' -e 's/where//g')

#get the table name
table_name=$(echo "$sql_line" | awk -F';' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
[ -f "$table_name" ] || exit 1

#get the column in the SET and check its existance
update_col_name=$(echo "$sql_line" | awk -F';' '{print $2}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
field_no=$(awk -F'|' 'BEGIN{found=0} {if (NR==1){for(i=1;i<=NF;i++){if($i=="'$update_col_name'")found=i}}} END{print found}' "$table_name")
col_data_type=$(awk -F'|' '{if ($1=="'$update_col_name'"){print $2}}' ".$table_name")
is_pk=$(awk -F'|' '{if ($1=="'$update_col_name'"){print $3}}' ".$table_name")
if ((field_no == 0)); then exit 2; fi

#get the column in the WHERE condition and check its existance
column_name=$(echo "$sql_line" | awk -F';' '{print $3}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
found=$(awk -F'|' 'BEGIN{found=0} {if(NR==1){for(i=1;i<=NF;i++){if($i=="'$column_name'")found=1}}} END{print found}' "$table_name")
if ((found == 0)); then exit 2; fi

#get the value in the WHERE condition and check its existance
selected_record=$(echo "$sql_line" | awk -F';' '{print $3}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
record_field=$(awk -F'|' 'BEGIN{found=0} {if(NR!=1){for(i=1;i<=NF;i++){if($i=="'$selected_record'")found=i}}} END{print found}' "$table_name")
if ((record_field == 0)); then exit 3; fi

#validate the new value with the column type
new_value=$(echo "$sql_line" | awk -F';' '{print $2}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
case $new_value in
[a-zA-Z]*) if ((col_data_type != "txt")); then exit 4; fi ;;
[0-9]*) if ((col_data_type != "int")); then exit 4; fi ;;
*) exit 4 ;;
esac

# check if the update value in pk column and the new value exists
if ((is_pk == "pk")); then
        value_exist=$(awk -v new_value="$new_value" -F'|' 'BEGIN{found=0} {if(NR!=1){for(i=1;i<=NF;i++){if($"'$selected_record'"==new_value)found=1}}} END{print found}' "$table_name")
        if ((value_exist == 1)); then exit 5; fi
fi

#update the selected record with the new value
awk -v new_value="$new_value" -i inplace -F'|' '{OFS=FS}{if($"'$record_field'"=="'$selected_record'"){$"'$field_no'"=new_value } print}' "$table_name" 2>../../error.log