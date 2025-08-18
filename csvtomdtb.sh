#! /bin/bash

ctr=0

if [ ! $2 ]; then
  echo 'please enter a csv file as an input file'
  exit 1
fi


if [ -f $3 ]; then
  read -p 'This will overwrite an existing file. Continue? (Y/N)  ' confirm && [[ $confirm == [yY] ]] || exit 1

  # instead of removing the file we will move it to the trash
  gio trash $2 
fi





while IFS= read -r line; do
  nline=$(echo $line | sed 's;,; | ;g')
  nline=$(echo $nline | tr -d "\r\n") # removing line end (csv was from google sheets)

  nline=$(echo "| "$nline" |")

  echo $nline >> $2

  if [[ $ctr == 0 ]]; then
    
    ctr=1

    # building new separator line NOW WITH REGEX!
    echo $nline | sed 's/[A-Z]*\b/ :-: /Ig' >> $2

  fi

done < $1


