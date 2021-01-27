#! /bin/bash
read -p "Enter Database name: " name

cd DBMS/$name 2>> error.log && echo "Database <$name> Selected Successfully" &&  ../../db_menu.sh $name || echo "Database $name Not Exist"
