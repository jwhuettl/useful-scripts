#! /bin/bash

ctr=0

if [ ! $2 ]; then
  echo 'please name a target file'
  exit 1
fi


if [ -f $2 ]; then
  read -p 'This will overwrite an existing file. Continue? (Y/N)  ' confirm && [[ $confirm == [yY] ]] || exit 1

  rm $2
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


