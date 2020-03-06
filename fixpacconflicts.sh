#!/bin/bash


# TODO: TBH, this should check the common ancestor of the moved files, 
# otherwise they might be conflicting within each other


function help() {
	echo "Usage:"
	echo "./fixpacconflicts.sh filelist dirname"
	echo ""
	echo "filelist: file with list of conflicts (pasted whole lines from pacman output"
	echo "dirname: directory in which to put conflicting files"
}

if [[ $# -ne 2 ]]; then
	echo "Bad args"
	echo ""
	help
fi

filelist=$1
dirname=$2

files=$(cat $filelist | awk '{print $2}')


# Check no file is actually owned
for f in $files; do
	res=$(sudo pacman -Qo $f 2>/dev/null)

	if [[ $? -eq 0 ]]; then
		echo "Cannot fix automatically."
		echo $res
		exit 1
	fi
done


mkdir -p $dirname/conflicts
touch $dirname/info

echo $flelist > $dirname/info

for f in $files; do
	mv $f $dirname/conflicts
done

echo "Moved conflicting files to $dirname/conflicts"
echo "List of conflicts available in $dirname/info"

