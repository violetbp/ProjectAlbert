#bash GradeInteractiveJava.sh ${sources[*]}

#Teacher program returns 1 - kills stduent
#teacher program returns 0 - waits for student to finish
#or wrap teacher program in script that returns fail once it is done

# Teachers File should output to System Error "--AUTOGRADE CORRECT-- if correct and --AUTOGRADE FALSE-- if false

#
#../timeout.pl -c -x 1 pipexec -k -- [A /bin/bash ../returnRedirect java T1 ] [B /bin/bash ../returnRedirect java T2 ] [COPY1 /usr/bin/tee -a log.txt ] [COPY2 /usr/bin/tee -a log.txt ] [COPY3 /usr/bin/tee returnCode1 ] [COPY4 /usr/bin/tee returnCode2 ] [PRE1 /bin/bash ../predate.sh "STUDENT" ] [PRE2 /bin/bash ../predate.sh "TEACHER" ] [ERR1 /usr/bin/tee grader.err ] [ERR2 /usr/bin/tee submission.err ] "{A:3>COPY3:0}" "{B:3>COPY4:0}" "{A:1>PRE1:0}" "{PRE1:1>B:0}" "{PRE1:100>COPY1:0}" "{B:1>PRE2:0}" "{PRE2:1>A:0}" "{PRE2:100>COPY2:0}" "{A:2>ERR1:0}" "{B:2>ERR2:0}"

function run {





#TODO sandbox
for i in "${sources[@]}"
do

log="Users/${userID}/${problemID}/${submitID}/log-${n}.txt"
teacherReturn="Users/${userID}/${problemID}/${submitID}/teacherReturn-${n}"
studentReturn="Users/${userID}/${problemID}/${submitID}/studentReturn-${n}"
graderErr="Users/${userID}/${problemID}/${submitID}/grader-${n}.err"
studentErr="Users/${userID}/${problemID}/${submitID}/submission-${n}.err"
timeoutOut="Users/${userID}/${problemID}/${submitID}/timeout-${n}.out"
perl timeout.pl -c -x 1 -t 8 ./pipexec -k -- [A /bin/bash returnRedirect java -cp "Problems/${problemID}" $(basename "Problems/${problemID}/$inputFile" .class) $1 ] [B /bin/bash returnRedirect java "-Xmx64m" "-Xms8m" -cp "Users/${userID}/${problemID}/${submitID}" $(basename "Users/${userID}/${problemID}/${submitID}/${i}" .java) ] [COPY1 /usr/bin/tee -a $log ] [COPY2 /usr/bin/tee -a $log ] [COPY3 /usr/bin/tee $teacherReturn ] [COPY4 /usr/bin/tee $studentReturn ] [PRE1 /bin/bash predate.sh "STUDENT" ] [PRE2 /bin/bash predate.sh "TEACHER" ] [ERR1 /usr/bin/tee $graderErr ] [ERR2 /usr/bin/tee $studentErr ] "{A:3>COPY3:0}" "{B:3>COPY4:0}" "{A:1>PRE1:0}" "{PRE1:1>B:0}" "{PRE1:100>COPY1:0}" "{B:1>PRE2:0}" "{PRE2:1>A:0}" "{PRE2:100>COPY2:0}" "{A:2>ERR1:0}" "{B:2>ERR2:0}" > /dev/null 2> $timeoutOut
execrtrn=$?
cat "$studentErr" | grep "Error: Main method not found in class " > /dev/null
if [[ $? == 1 ]]; then
	mainFound=true	
	break;
fi
rm "$log"
rm "$teacherReturn"
rm "$studentReturn"
rm "$graderErr"
rm "$studentErr"
done

if [ ! $mainFound == true ]; then
	printf "Could not find main function\n"
	return 1
fi
	


cat "$studentErr" | grep -w "java.lang.OutOfMemoryError:" > /dev/null
#cat "$runerr" | grep -w "MEM"
	if [[ $? == 0 ]]; then
		printf "Program used too much memory\n"
		return 1
fi

cat "$timeoutOut" | grep "^TIMEOUT" > /dev/null
	if [[ $? == 0 ]]; then
		printf "time limit is exhausted\n"
		return 1
fi

cat "$timeoutOut" | grep "^HANGUP" > /dev/null
	if [[ $? == 0 ]]; then
		printf "Program Hungup\n"
		return 1
fi

cat "$timeoutOut" | grep "^SIGNAL" > /dev/null
	if [[ $? == 0 ]]; then
		printf "Program was termined by signal\n"
		return 1
fi

	if (( $execrtrn >= "128" )) ; then
		printf "Probram was killed\n"
		cat "$log"
		return 1
	elif [ $(cat $studentReturn) == "1" ] ; then
		echo "Runtime Errors:"
		cat "$studentErr"
		return 1
	elif [ $(cat $teacherReturn) == "0" ] ; then
		#echo "Program Ran Successfully"
		return $(cat $teacherReturn)
	else
		printf "Wrong\n"
		printf "\n"
		cat "$log"
		return 1
	fi
}


for ((n=1; n<=inputNum; n++)); do
	run $n
	if [ $? == 1 ] ; then
		exit 1
	fi
done
printf "CORRECT\n"
