#!/bin/bash
if [[ $# -eq 0 || $# -eq 1 ]]
then
       	#exit 1;
	echo "enter both table name and option"
elif [ "$1" = "all" ] && [ -f $2 ]

	then 
		cat $2;
	#exit 2;
elif [ "$1" !=  "all" ] && [ -f $2 ]
       	then 
	#exit 3;
	echo "enter valid option (all)"
	else
		echo "Table not exist"
fi




