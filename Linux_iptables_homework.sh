while true
do
    read -p "Read, Block, Unblock or Exit: " operation
    if [ "$operation" = "Exit" ];then
	break
    elif [ "$operation" = "Block" ];then
	read -p "Please input website:" website
	echo "$website has been blocked"
	iptables -A OUTPUT -d $website -j DROP
	echo "$website" >> block_file.txt
	
    elif [ "$operation" = "Unblock" ];then
	read -p "Please input website:" website	
        if [ `grep -c $website block_file.txt` -eq 0 ];then
	    echo "$website not have"
	else
	    echo "$website has been unblocked"
	    iptables -D OUTPUT -d $website -j DROP
       	    sed -i '/'"$website"'/d' block_file.txt
	fi
    elif [ "$operation" = "Read" ];then
    	echo "The following websites are blocked:\n"
	cat block_file.txt | while read line
	do
    	    echo $line
        done
    fi
    
done
