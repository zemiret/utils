#!/bin/bash

# This script can be used in a directory to fix EXIF orientation
# of all .jpg files in that dir.


fixorient() {
	tofix=$1

    orientation=$(exiftool -orientation -n $tofix | awk -F':' '{print $2}' | tr -d '\t\n\r\f ')
    
    case $orientation in
    	2)
			echo "FIXING $tofix: Flip horizontal"
    		cp $tofix tmp.jpg
    		jpegtran -flip horizontal tmp.jpg > $tofix
    		rm tmp.jpg
    		;;
    	3)
			echo "FIXING $tofix: 180 rotation"
    		cp $tofix tmp.jpg
    		jpegtran -rot 180 tmp.jpg > $tofix
    		rm tmp.jpg
    		;;
    	4)
			echo "FIXING $tofix: 180 rotation + flip horizontal"
    		cp $tofix tmp.jpg
    		jpegtran -rot 180 tmp.jpg > tmp1.jpg
    		jpegtran -flip horizontal tmp1.jpg > $tofix
    		rm tmp.jpg
    		rm tmp1.jpg
    		;;
    	5)
			echo "FIXING $tofix: 90 rotation + flip horizontal"
    		cp $tofix tmp.jpg
    		jpegtran -rot 90 tmp.jpg > tmp1.jpg
    		jpegtran -flip horizontal tmp1.jpg > $tofix
    		rm tmp.jpg
			rm tmp1.jpg
    		;;
    	6)
			echo "FIXING $tofix: 90 rotation"
    		cp $tofix tmp.jpg
    		jpegtran -rot 90 tmp.jpg > $tofix
    		rm tmp.jpg
    		;;
    	7)
			echo "FIXING $tofix: 270 rotation + flip horizonal"
    		cp $tofix tmp.jpg
    		jpegtran -rot 270 tmp.jpg > tmp1.jpg
    		jpegtran -flip horizontal tmp1.jpg > $tofix
    		rm tmp.jpg
			rm tmp1.jpg
    		;;
    	8)
			echo "FIXING $tofix: 270 rotation"
    		cp $tofix tmp.jpg
    		jpegtran -rot 270 tmp.jpg > $tofix
    		rm tmp.jpg
    		;;
    	*)
			echo "OK $tofix"
    		;;
    esac
}

fixlist=$(ls | grep -E "*.jpg")

for file in $fixlist; do
	fixorient $file
done

