### ARGUMENTS

# For simplicity I define the arguments 
folder=$1
lines=$2

	# If no folder is provided, the search is donde in the current folder
	if [[ -z $folder ]]; then folder=$(pwd); fi  

	# If no number of lines is provided no lines are shown.
	if [[ -z $lines ]]; then lines=0; fi

### REPORT
echo ========== FA AND FASTA FILES REPORT ==========
echo "The search has been performed in $folder"
echo

#Find and count fasta and fa files and symlinks
files=$(find "$folder" \( -type l -o -type f \) \( -name "*.fa" -o -name "*.fasta" \))
n_files=$(find "$folder" \( -type f -o -type l \) \( -name "*fa" -o -name "*fasta" \) | wc -l)

if [[ $n_files -gt 0 ]]; then #check if fa and fastafiles present in the folder and subfolders

#Number of .fa and .fasta files
echo "1) Number of .fa and .fasta files => $n_files"

# Unique IDs
unique=$(awk '/>/{print $1}' $files | sort | uniq | wc -l)
total=$(awk '/>/{print $1}' $files | wc -l)
echo
echo "2) Number of unique IDs is $unique form $total total IDs"
echo

### REPORT FOR EACH FILE
echo "3) Report for each file"
echo

for i in $files; do

#Header
echo "----- FILE: $(echo $i)" #If we want only the filename $(echo $i|awk -F"/" '{print $NF}')"
echo       
	
# Check if it is a symlink or not 
if [[ -h $i ]]; then
echo "  3.1) IS a symlink"
else 
echo "  3.1) Is NOT a symlink"
fi

#Number of sequences in the fasta files
echo "  3.2) There are $(grep -c -I ">" $i) sequences in the file."
if [[ $(grep -c -I ">" $i) -eq 0 ]]; then
echo "Skipping the rest of the iteration as it does not have sequences"
echo
continue
fi

#Total sequence length:
echo "  3.3) The total sequences length is $(grep -v ">" $i| grep -io [A-Z]|wc -l)"

#Check if there are nt or proteic secuences
if grep -v ">" $i | tr -d '\n' | grep -Eiq "^[ATGCU-]+$"; then 
echo "  3.4) There are nucleotidic sequences in the file"
else 
echo "  3.4) There are proteic sequences in the file"
fi

#Display lines
linecount=$(wc -l < $i)
if [[ lines -eq 0 ]]; then 
echo "  3.4) The file has $linecount lines."
else

if [[ $linecount -le 2*$lines ]]; then
echo "  3.5) The file has less than $((2*$lines)) lines. Displaying full content"
cat $i
else
echo "  3.5) The file has $linecount lines. Displying first and last $lines lines."
echo
echo "=> First $lines lines: $(head -n $lines $i)"
echo "..."
echo "=> Last $lines lines: $(tail -n $lines $i)"   
fi

fi

echo

done

else
echo "There are not fasta or fa files in $folder and subfolders"
fi 



