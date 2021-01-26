#! /bin/bash
read -p "Enter table Name: " name
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
			read -p "Enter $colname ($coltype)($colkey) : " value;
			if [[ $coltype = "int" &&  $value =~ ^[0-9]*$ || $coltype = "txt" && $value = [a-zA-Z] ]]
		       	then
				if [[ $colkey = "pk" && $value = " " ]]
				then
					echo "!<... Primary Key Can't Be Null ...> !"
				fi

		 		if [ $i -ne $colsNum ]
			       	then
		 			echo -n $value"|" >> $name;
		 		else	
		 			echo -e $value '\n' >> $name;
					echo "Data inserted Successfully"
		 		fi
				flag=1;
			else
				echo "Invalid input"
		 	fi
	 	done
	done
else
	echo "$name Not Exist";
fi
