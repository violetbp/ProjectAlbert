#bash GradeInteractiveJava.sh ${sources[*]}


function compare {
	if diff -q --strip-trailing-cr -B -Z "$1" "$2" > /dev/null ; then
			#echo "Correct!"
			return 0
		else		
			printf "Does not match expected output\n"
		#	diff -y --strip-trailing-cr -B -Z -W 30 $1 $2
	printf "Your output\n"
      cat "$1"
      printf "Expected Output\n"
      cat "$2"
		printf "\n"
			return 1
	fi
}

#run inputfile outputfile
function run {
			timeGiven=6
			memGiven=6400
			output="Users/${userID}/${problemID}/${submitID}/output-${input}"
			runerr="Users/${userID}/${problemID}/${submitID}/runtime-${input}.err"
#TODO sandbox


perl "$timeout" -t "$timeGiven" -m $memGiven -x 1 --confess --detect-hangups Users/"${userID}"/"${problemID}"/"${submitID}"/"${exacutable}" 1> "$output" < "$1" 2>"$runerr"

	execrtrn=$?

cat "$runerr" | grep "^MEM" > /dev/null
	if [[ $? == 0 ]]; then
		printf "Program used too much memory\n"
		return 1
fi

cat "$runerr" | grep "^TIMEOUT" > /dev/null
	if [[ $? == 0 ]]; then
		printf "time limit is exhausted\n"
		return 1
fi

cat "$runerr" | grep "^HANGUP" > /dev/null
	if [[ $? == 0 ]]; then
		printf "Program Hungup\n"
		return 1
fi

cat "$runerr" | grep "^SIGNAL" > /dev/null
	if [[ $? == 0 ]]; then
		printf "Program was termined by signal\n"
		return 1
fi

	if (( $execrtrn >= "128" )) ; then
		printf "Probram was killed\n"
		printf "Program returned error code $($execrtrn-128)\n"
		cat "$runerr"
		return 1
	elif [ $execrtrn == "1" ] ; then
		echo "Runtime Errors:"
		cat "$runerr"
		return 1
	elif [ $execrtrn == "0" ] ; then
		#echo "Program Ran Successfully"
		compare "$output" "$2"
		return "$?"
	else
		printf "Unknown Error: "
		printf $execrtrn
		printf "\n"
		cat "$runerr"
		return 1
	fi
}

for input in ${inputs[@]}
do
	temp=${outputs[$input]}
	run "Problems/${problemID}/${input}.in" "Problems/${problemID}/${temp}.out"
	if [ $? == 1 ] ; then
		exit 1
	fi
done

echo Correct
