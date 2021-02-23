#!/bin/bash
name=$(zenity --entry --width=500 --height=200   --ok-label="Ok" --cancel-label="Exit"\
        --title "Insert Into $name Table" \
        --text "Enter the Table Name?" \
         --entry-text "TableName" \
)
status=$?
if [ $status -eq 1 ]
     then
       exit;
else
		      case $name in
		        "TableName") zenity --warning  --width=400 --height=200 --title="Using DBMS Engin Status"  --ok-label="Back" --text="You Must Enter Database Name"
									        if [[ $? -eq 0 ]]
									        then
									          . ../../db_menu.sh
									        else
									          exit
									        fi ;;

		        *)
							if [[ -f $name ]]
							then
											colsNum=`awk 'END{print NR}' .$name`
							  			for (( i= 1; i<= $colsNum; i++ ))
								  		do
										    		colname=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$name)
										   		  coltype=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$name)
										    		colkey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$name)
											    	flag=0;
											     	while [ $flag -eq 0 ]
											      do
																value=$(zenity --entry --width=500 --height=200   --ok-label="Ok" --cancel-label="Exit"\
																        --title "Insert Into $name Table" \
																        --text "Enter $colname ($coltype)($colkey)" \
																					)
																	if [[ $coltype = "int" &&  $value =~ ^[0-9]*$ && $colkey != "pk" || $coltype = "txt" && $value =~ ^[a-zA-Z]*$ || $coltype = "int" && $colkey = "pk" && $value = [0-9]* ]]
												       		then
												 								if [ $i -ne $colsNum ]
													       				then
												 											echo -n $value"|" >> $name;
												 								else
												 											echo  $value >> $name;
												 								fi
																flag=1;
												        fi
											 	     done
								       done
								else exit 1;
								fi
									;;
                esac

fi
