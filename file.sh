declare seq
if [[ $# == 1 ]]; then
  seq=1
elif [[ $# == 2 ]]; then
  seq=$2
fi

echo "-------------------------------------------"
echo "target directory: $1"
echo "-------------------------------------------"
echo "-------------------------------------------"
echo "sequence will start from $seq"
echo "-------------------------------------------"

echo "-------------------------------------------"
echo "existing files:"
ls "$1"
echo "-------------------------------------------"
echo '!!!!! These existing files may be renamed !!!!! continue? [y/N]'
read -r

if [[ $REPLY != 'y' ]]; then
  exit 0
fi

while true; do
  files=$(ls "$1")
  for file in ${files[@]}; do
    if ! [[ $file =~ ^[0-9]{3}\..+$ ]]; then
      sequence=$(printf "%03d" $seq)
      extension=${file##*.}
      mv "$1/$file" "$1/$sequence.$extension"
      echo "$1/$file was renamed to $1/$sequence.$extension"
      seq=$((seq + 1))
    fi
  done
  sleep 1
done
