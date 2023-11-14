# For simplicity I define the arguments 
folder=$1
lines=$2

# If no folder is provided, the search is donde in the current folder
if [[ -z $folder ]]; then folder=$(pwd); fi  



# Report
echo ===== FA AND FASTA FILES REPORT =====
echo "The search has been performed in $folder"

if [[ $(find $folder -type f -name "*fa" -o -name "*fasta"|wc -l) -gt 0 ]]; then
echo "1) Number of .fa and .fasta files => $(find $folder -type f -name "*fa" -o -name "*fasta"|wc -l)"

unique=$(awk '/>/{print $1}' $(find $folder -type f -name "*fasta" -o -name "*fa") | sort | uniq | wc -l)
total=$(awk '/>/{print $1}' $(find $folder -type f -name "*fasta" -o -name "*fa") | wc -l)
echo "2) Number of unique IDs is $unique form $total total IDs"

#Report for each files
echo "3) Report for each file"
for i in $(find $folder -type f -name "*fa" -o -name "*fasta"); do
echo "--> File: $(basename $i)" #Header

# Check if it is a symlink or not --> Shouldnt be because we are searching for files (-o type l)
if [[ -h $i ]]; then
echo "IS a symlink"
else 
echo "NOT a symlink"
fi

# Number of sequences
echo "There are $(grep -c ">" $i) sequences."



done

fi 



