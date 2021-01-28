#! /bin/bash

read -p "Enter Table Name: " name
if [ -f $name ]
then
	NR1=`awk 'END{print NR}' $name`
	awk 'BEGIN{FS="|"}{if(NR==1){print $0}}' $name
	read -p "Enter column to delete record from: " coldel
	col=`awk 'BEGIN{FS="|";c=0}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$coldel'"){ c=1 ;print c}}}}' $name`
	read -p "Enter value: " vldel
	awk 'BEGIN{FS="|"}
	{	if(NR==1){for(i=1;i<=NF;i++){if($i=="'$coldel'"){field=i}}}
		else{if($field == "'$vldel'"){loc=NR}}
		{if(NR!=loc) print}
	}' $name  > tmp && mv tmp $name

	NR2=`awk 'END{print NR}' $name`
	if [[ "$NR1" -eq "$NR2" ]] && [[ "$col" = 1 ]]
	then exit 1;

	elif [[ "$col" -eq 0 ]]
	then exit 2; fi

else exit 3; fi
