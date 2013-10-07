#!/bin/bash

packstack --gen-answer-file=/tmp/answers.txt
grep "_PW="     /tmp/answers.txt >  /tmp/packstack-passwords.txt 
grep "_TOKEN="  /tmp/answers.txt >> /tmp/packstack-passwords.txt 
grep "_SECRET=" /tmp/answers.txt >> /tmp/packstack-passwords.txt   
rm /tmp/answers.txt
        