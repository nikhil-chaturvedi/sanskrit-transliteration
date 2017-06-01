#!/bin/bash
for (( i=1; i<=$2; i++ ))
do
	wget http://$1.wikipedia.org/wiki/Special:Random -q --show-progress -O $1/$i.html
done