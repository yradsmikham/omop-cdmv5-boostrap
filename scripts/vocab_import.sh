FILES="../vocab/*"
for f in $FILES
do
  short_f="$(basename -- $f)"
  fname_next="${short_f%.*}"
  echo "Processing $fname_next file..."
  bcp $fname_next in $f -S "$1" -d "$2" -U "$3" -P "$4" -q -c
done
