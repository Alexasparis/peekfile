if [ -z "$2" ]; then
    set -- "$1" 3
fi

if [ "$(wc -l<"$1")" -le "$((2*$2))" ]; then
    echo "File contains less than $((2*$2)) lines. Full content of the "$1" is shown"
    cat "$1"
else
    echo "File contains more than $((2*$2)) lines"
    head -n "$2" "$1"
    echo "..."
    tail -n "$2" "$1"
fi


