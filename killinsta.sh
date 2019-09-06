#!/bin/bash
for arg in "$@"
do
	ps -e | grep "$arg" -m 1 | grep -o '[0-9]*' | head -1 | xargs kill
done
