#!/bin/bash
# update Raouf set id=5 where name=ama
read -p "Table Name : " table_name
[ -f "$table_name" ] || exit 1

#select the column to search for value
read -p "Select With Column Name : " column_name
found=$(awk 'BEGIN{FS="|"; found=0} {if (NR==1){for(i=1;i<=NF;i++){if($i=="'$column_name'")found=1}}} END{print found}' "$table_name")
if ((found==0)); then echo "failed Col Name"; exit 2; fi;

#read the value to select its column
read -p "Select By Value : " selected_record
line_no=$(awk 'BEGIN{FS="|"; found=0} {for(i=1;i<=NF;i++){if($i=="'$selected_record'")found=NR}} END{print found}' "$table_name")
if ((line_no==0)); then exit 3; fi;

#read the column to update
read -p "Update Column : " update_col_name
field_no=$(awk 'BEGIN{FS="|"; found=0} {if (NR==1){for(i=1;i<=NF;i++){if($i=="'$update_col_name'")found=i}}} END{print found}' "$table_name")
col_data_type=$(awk 'BEGIN{FS="|"} {if ($1=="'$update_col_name'"){print $2}}' "$table_name")
if ((field_no==0)); then  exit 2; fi;

#validate the new value with the column type
read -p "New Value : " new_value
case $new_value in
        [a-zA-Z]* ) if (( col_data_type!="txt")); then exit 4; fi ;;
        [0-9]* )    if (( col_data_type!="int")); then exit 4; fi ;;
esac

#update the selected record with the new value
awk  'BEGIN{FS="|"} {if (NR=="'$line_no'"){ $"'$field_no'"="|'$new_value'"; gsub(" ","",$0) } print > "Raouf" }' "$table_name" 2> ../../error.log
# awk  'BEGIN{FS="|"} {if ($1 == "1"){ $2="|Ohyea"; gsub(" ","",$0) } print > "Raouf" }' Raouf