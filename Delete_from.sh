#! /bin/bash
read -p "Enter Table Name: " name
if [ -f $name ]
then
	awk 'BEGIN{FS="|"}{if(NR==1){print $0}}' $name
	read -p "Enter column to delete record from: " coldel
	read -p "Enter value: " vldel
	awk 'BEGIN{FS="|"}
	{	if(NR==1){for(i=1;i<=NF;i++){if($i=="'$coldel'"){field=i}}}
		else{if($field == "'$vldel'"){loc=NR}}
		{if(NR!=loc)print}
	}' $name > tmp && mv tmp $name

	echo "Row Deleted Successfully"
else
	echo "$name Not Exist"
fi
