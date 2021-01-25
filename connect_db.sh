#! /bin/bash
read -p "Enter Database name: " name
cd DBs/$name 2>> error.log && echo " $name Database Selected Successfully" && P3=$name  || echo "Database $name Not Exist" 

