#!/bin/bash

shopt -s nullglob extglob

for file in *.+(flac|alac|m4a);
do
  
  ffmpeg -i "${file}" -b:a 192k -vn "${file%.*}".mp3
  
  if [$1 == clean | $1 == c]; then
    mv "${file}" .local/share/Trash/files
  fi

done

