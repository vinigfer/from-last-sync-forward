#!/bin/bash

Last_time_checked=`cat .Last_time_checked.txt`
echo "Looking for files created after: "$Last_time_checked

user="username"
server="server_address.com"
File_list="Files_to_Transfer.txt"
local_folder="/home/vinicius/Documentos"

ssh $user@$server '(find /home/'"$user"'/Transmission_Downloads/ \
                                    -type f \( -iname "*.mp4" -o \
                                               -iname "*.mkv" -o \
                                               -iname "*.avi" -o \
                                               -iname "*.zip" -o \
                                               -iname "*.flv" -o \
                                               -iname "*.rar" \) \
                                    -newermt '\""$Last_time_checked"\"')' | grep -v sample | | sort -r > $File_list

echo "The following files will be downloaded:"
cat $File_list

cat $File_list | while read File_path_on_server
do
    rsync --protect-args -aP "$user@$server:$File_path_on_server" $local_folder
    #Capture rsync error if we hit Ctrl+C . Prevent date file from being updated
    if [ "$?" -ne "0" ]
    then
        sleep 2
        kill 0
    fi
done

rm $File_list

#Save to a file the last time we pulled files from the server
echo `date +%Y-%m-%d` `date +%H:%M:%S` > .Last_time_checked.txt

exit
