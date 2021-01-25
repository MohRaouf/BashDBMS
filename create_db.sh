#!/bin/bash
echo -n "Enter the Database name : "
read db_name
mkdir DBMS/$db_name 2>>error.log && echo "Created Successfully" || echo "Failed"