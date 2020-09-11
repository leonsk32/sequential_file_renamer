echo "-------------------------------------------"
echo "target directory: $1"
echo "-------------------------------------------"

i=1
echo "-------------------------------------------"
echo "existing files:"
ls "$1"
echo "-------------------------------------------"
echo 'These existing files may be renamed. Is it ok? [y/N]'
read -r

if [[ $REPLY != 'y' ]]; then
  exit 0
fi

while true; do
  array=$(ls "$1")
  for file in ${array[@]}; do
    if ! [[ $file =~ ^[0-9]{3}\..+$ ]]; then
      seq=$(printf "%03d" $i)
      ext=${file##*.}
      mv "$1/$file" "$1/$seq.$ext"
      echo "$1/$seq.$ext"
      i=$((i + 1))
    fi
  done
  sleep 1
done
