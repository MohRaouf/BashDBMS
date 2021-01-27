#!/bin/bash
# update Raouf set id=5 where name=ama
echo -e "e.g. UPDATE table; SET column1=value1; WHERE column2=value2;"
read -p "Enter SQL Statement : " sql_line
table_name=$(echo "$sql_line" |tr  "[:upper:]" "[:lower:]" | sed -e 's/update//g' -e 's/set//g' -e 's/where//g' | awk -F';' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
[ -f "$table_name" ] || exit 1

#select the column to search for value
column_name=$(echo "$sql_line" |tr  "[:upper:]" "[:lower:]" | sed -e 's/update//g' -e 's/set//g' -e 's/where//g' | awk -F';' '{print $3}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
found=$(awk 'BEGIN{FS="|"; found=0} {if (NR==1){for(i=1;i<=NF;i++){if($i=="'$column_name'")found=1}}} END{print found}' "$table_name")
if ((found==0)); then exit 2; fi;

#read the value to select its column
selected_record=$(echo "$sql_line" |tr  "[:upper:]" "[:lower:]" | sed -e 's/update//g' -e 's/set//g' -e 's/where//g' | awk -F';' '{print $3}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
line_no=$(awk 'BEGIN{FS="|"; found=0} {for(i=1;i<=NF;i++){if($i=="'$selected_record'")found=NR}} END{print found}' "$table_name")
if ((line_no==0)); then exit 3; fi;

#read the column to update
update_col_name=$(echo "$sql_line" | tr  "[:upper:]" "[:lower:]" |sed -e 's/update//g' -e 's/set//g' -e 's/where//g' | awk -F';' '{print $2}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$1);print $1}')
field_no=$(awk 'BEGIN{FS="|"; found=0} {if (NR==1){for(i=1;i<=NF;i++){if($i=="'$update_col_name'")found=i}}} END{print found}' "$table_name")
col_data_type=$(awk 'BEGIN{FS="|"} {if ($1=="'$update_col_name'"){print $2}}' ".$table_name")
is_pk=$(awk 'BEGIN{FS="|"} {if ($1=="'$update_col_name'"){print $3}}' ".$table_name")
if ((field_no==0)); then  exit 2; fi;

#validate the new value with the column type
new_value=$(echo "$sql_line" | tr  "[:upper:]" "[:lower:]" |sed -e 's/update//g' -e 's/set//g' -e 's/where//g' | awk -F';' '{print $2}' | awk -F'=' '{gsub(/^[ \t]+|[ \t]+$/, "",$2);print $2}')
case $new_value in
        [a-zA-Z]* ) if (( col_data_type!="txt")); then exit 4; fi ;;
        [0-9]* )    if (( col_data_type!="int")); then exit 4; fi ;;
        * ) exit 4 ;;
esac

# check if the update value in pk column and the new value exists
if ((is_pk=="pk")); then 
        value_exist=$(awk 'BEGIN{FS="|"; found=0} {for(i=1;i<=NF;i++){if($i=="'$new_value'")found=1}} END{print found}' "$table_name")
        if ((value_exist==1)); then exit 5; fi
fi

#update the selected record with the new value
gawk -v new_value="$new_value" -i inplace -F'|' '{OFS=FS}{if (NR=="'$line_no'"){ $"'$field_no'"=new_value } print }' "$table_name" 2> ../../error.log 