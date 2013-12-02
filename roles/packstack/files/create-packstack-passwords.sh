#!/bin/bash

packstack --gen-answer-file=/tmp/answers.tmp
grep "_PW="     /tmp/answers.tmp >  /tmp/packstack-passwords.txt
grep "_TOKEN="  /tmp/answers.tmp >> /tmp/packstack-passwords.txt
grep "_SECRET=" /tmp/answers.tmp >> /tmp/packstack-passwords.txt
grep "_HASH=" /tmp/answers.tmp >> /tmp/packstack-passwords.txt
rm /tmp/answers.tmp
