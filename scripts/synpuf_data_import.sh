CSV_FILES="../synpuf_data/synpuf1k_omop_cdm_5.3.1/*.csv" # Change to this the appropriate directory name for data import
for f in $CSV_FILES
do
  short_f="$(basename -- $f)"
  fname_next="${short_f%.*}"
  echo "Processing $fname_next file..."
  bcp $fname_next in $f -S "$1" -d "$2" -U "$3" -P "$4" -q -c
done
