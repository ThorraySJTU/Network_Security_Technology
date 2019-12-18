#!/bin/bash

echo "This script searches the nonce with which the hash value of \"Hello World\" will begin with a certain number of 0."
read -p "The number of 0: n = " n

# To verify the hash string begins with how many 0s 
# generate a string z with n number of 0s
z=0
i=2
time=0
while [ $time -le 50 ]
do
    echo "n = $n"
    while [ $i -le $n ]  
    do 
        z=0$z
        i=$((i+1))
    done
    # echo $z

    # Do one test
    count=1
    nonce=`gpg --armor --gen-random 0 60 | cut -c -20` # generate random nonce with 20 charactors
    s=`echo ${nonce}"Hello World" | sha256sum`
    # While loop
    echo "Finding......."
    while [ "${s:0:$n}" != "$z" ]
    do 
        nonce=`gpg --armor --gen-random 0 60 | cut -c -20`
        s=`echo ${nonce}"Hello World" | sha256sum`
        count=$((count+1))
    done
    echo "Find!"
    time=$((time+1))
    # The result
    echo "time = $time" >> "$n".txt
    echo "nonce = $nonce" >> "$n".txt
    echo "steps = $count" >> "$n".txt
    echo ${nonce}"Hello World" | sha256sum >> "$n".txt
done
