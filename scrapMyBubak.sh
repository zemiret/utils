#!/bin/bash

curl --output tmp.html https://www.icsr.agh.edu.pl/~mownit/

links=$(cat tmp.html | grep -o -i -E "href=\"[^\"]*" | tail -n +2) 

mkdir bubakownia
cd bubakownia

for link in $links; do
    title=$(echo $link | awk -F / '{print $2}')
    link="https://www.icsr.agh.edu.pl/~mownit/pdf/$title"
    curl --output $title $link 
done

cd ..
rm tmp.html

