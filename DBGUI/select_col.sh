#!/bin/bash

if [[ $# -eq 0 || $# -eq 1 ]]
then echo "Enter Both Table Name And Option"
elif [ $# -eq 2 ]
then 
	if [ -f $2 ]
	then
		col_selected=`awk 'BEGIN{FS="|";col=0}{if(NR==1){for(i=1;i<=NF;i++) if($i == "'$1'"){col=i}}}END{print col}' $2`
		if  [ $col_selected -eq 0 ]
		then
			echo "Column Not Exist"
		else
			awk 'BEGIN{FS="|"}{print $'$col_selected' }' $2
		fi

	else
		echo "Table Not exist"
	fi
else
	echo "Enter valid Options (col & Table Name)"
fi



