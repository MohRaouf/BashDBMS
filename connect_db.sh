#! /bin/bash
echo -n "Enter Database name: "
read name 
cd DBMS/$name 2>> error.log && echo " $name Database Selected Successfully" || echo "Database $name Not Exist" 

