while read line ; do
    echo ${line}
    echo "$(date) - ${1}: ${line}" >&100
done
