#!/bin/bash

# check if imagemagick exists
if [ x$"which convert" == "x" ] || [ x$"which mogrify" == "x" ] || [ x$"which identify" == "x" ]; then
	echo "imagemagick not found, qutting"
	exit 1
fi

# check if dump folder exists
if [ ! -d "dump" ]; then 
    mkdir dump
fi

cnt=0

for fn in $(ls -1 *.png 2> /dev/null); do
	w=$(identify -format "%[fx:w]" $fn)
	h=$(identify -format "%[fx:h]" $fn)
	if [ $w == $h ]; then 
		convert "$fn" -quality 100 -resize 240x "${fn%%.*}.webp"
	else
		echo "$fn was not a square img, skipping"
	mv "$fn" dump/
	cnt=$(($cnt + 1))
done

echo "$cnt images moved to dump/"