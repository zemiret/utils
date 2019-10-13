#!/bin/bash

curdir=$(pwd)
cd ~/Pictures/Wallpapers

for wal in $(ls .); do
	echo $wal
	wal -i $wal
	sleep 3 
done

cd $curdir

