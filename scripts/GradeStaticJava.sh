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
			Xmx="-Xmx"
			m="m"
			output="Users/${userID}/${problemID}/${submitID}/output-${input}"
			runerr="Users/${userID}/${problemID}/${submitID}/runtime-${input}.err"
#TODO sandbox
for i in "${sources[@]}"
do
perl "$timeout" -t "$timeGiven" -x 1 --confess --detect-hangups java -cp "Users/${userID}/${problemID}/${submitID}" "-Xmx64m" "-Xms8m" $(basename "Users/${userID}/${problemID}/${submitID}/${i}" .java) 1> "$output" < "$1" 2>"$runerr"

cat "$runerr" | grep "Error: Main method not found in class " > /dev/null
if [[ $? == 1 ]]; then
	mainFound=true	
	break;
fi
rm "$runerr"
rm "$output"
done

if [ ! $mainFound == true ]; then
	printf "Could not find main function\n"
	printf "Count not find main function\n" >> run.dat
	return 1
fi
	
	execrtrn=$?


cat "$runerr" | grep -w "java.lang.OutOfMemoryError:" > /dev/null
#cat "$runerr" | grep -w "MEM"
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
