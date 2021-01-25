#! /bin/bash 
read -p  "Enter Database Name : " name
if [ -d DBMS/$name ]
then
        read -p "Are you sure You Want To Delete $name ? (Y/N) : " choice
        case $choice in
                [yY]*) rm -r DBMS/$name; echo "$name Deleted Successfully";;
                [nN]*) echo " Operation Canceled";;
                *) echo "Invalid option";;
        esac
else
        echo "$name Database Not Exist"
fi

