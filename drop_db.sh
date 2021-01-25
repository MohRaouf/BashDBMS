#! /bin/bash 
read -p  "Enter Database Name : " name
if [ -d DBMS/$name ]
then
        echo "Are you sure You Want To Delete $name?"
        read choice
        case $choice in
                [yY]*)
                        rm -r DBMS/$name
                        echo "$name Deleted Successfully";;
                [nN]*)
                        echo " Operation Canceled";;
                *)
                        echo "Invalid option";;
        esac
else
        echo "$name Database Not Exist"
fi

