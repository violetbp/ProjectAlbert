#!/bin/bash

#bash userSubmit.sh userID problemID submissionID language sourceFile1 sourceFile2...

#
 cd scripts
set -x

result="resault.dat"
runtimeErr="runtime.err"
compileErr="compile.err"
exacutable="exe"
graderData="graderData.conf"
timeout="timeout.pl"

userID=$1
problemID=$2
submitID=$3
lang=$4 #langs supported: cpp, c, java, python
shift 4

if [ ! -d "Users" ]; then
	printf "SERVER ERROR - User folder DOSNT EXIST\n"
	exit 1
fi

if [ ! -d "Users/${userID}" ]; then
	printf "SERVER ERROR - User does not exist\n"
	exit 1
fi

if [ ! -d "Users/${userID}/${problemID}" ]; then
	printf "SERVER ERROR - Problem does not exist\n"
	exit 1
fi

if [ ! -d "Users/${userID}/${problemID}/${submitID}" ]; then
	printf "SERVER ERROR - Submission does not exist\n"
	exit 1
fi

if [ $lang != "java" ] && [ $lang != "cpp" ] && [ $lang != "c" ] && [ $lang != "py" ]; then
	printf "SERVER ERROR - Langauge not supported: Must be py, c, cpp, java\n"
	exit 1
fi

#if [ ! -f "Problems/${problemID}/${graderData}" ]; then
#	printf "SERVER ERROR - GraderData does not exist\n"
	#exit 1
#fi

# check if the file contains something we don't want
#if egrep -q -v '^#|^[^ ]*=[^;]*' "Problems/${problemID}/$graderData"; then
#  	printf "SERVER - GraderData file is unclean, cleaning it..." >&2
#  	# filter the original to a new file
#
#	graderData_secured="{$graderData}_safe"
#	while [ -f "Problems/${problemID}/${graderData_secured}" ]; do
#		graderData_secured="{$graderData_secured}_"
#		exit 1
#	done
#
#	 egrep '^#|^[^ ]*=[^;&]*'  "$graderData" > "$graderData_secured"
# 	 graderData="$graderData_secured"
#fi

#source "Problems/${problemID}/$graderData"

autograde=$(sqlite3 ../db/development.sqlite3 "select grading_type from problems where id=${problemID}")

if [ $autograde = "inter" ]; then
autograde="interactive"
fi

#config should include
#autograde=interactive
#autograde=static
#autograde=off

if [ $autograde != "interactive" ] && [ $autograde != "static" ] && [ $autograde != "off" ]; then
  printf "SERVER ERROR - Grading type not supported\n"
	exit 1
fi

if [ $autograde == "interactive" ]; then
  inputLang=java
  inputFile=$(sqlite3 ../db/development.sqlite3 "select active_probs from problems where id=${problemID}")
  inputNum=2
  #do 2 tests, change eventually
fi

if [ $autograde == "static" ]; then
  declare -A outputs
  temp=($(sqlite3 ../db/development.sqlite3 "select active_probs from problems where id=${problemID}"))
  for i in "${temp[@]}"
  do
    inputs[${#inputs[@]}] = ${i}.in
    outputs[${i}.in] = ${i}.out
   # do whatever on $i
  done
fi

if [ "$#" -eq 0 ]; then
	printf "SERVER ERROR - No source files provided\n"
	exit 1
else
  sources=( "$@" )
fi

cd "Users/${userID}/${problemID}/${submitID}"

for i in "${sources[@]}"; do
	if [ ! -f "$i" ]; then
		printf "SERVER ERROR - Expected source file nonexcistent\n"
		exit 1
	fi
done



#TODO make compileing safe
#TODO make System.exit(0) must always exit zero

if [ $lang == "java" ] ; then

cat "${sources[@]}" | grep -w "package"
#cat "$runerr" | grep -w "MEM"
	if [[ $? == 0 ]]; then
		printf "Error: package decleration detected\n"
		exit 1
fi

#TODO error if class names dont match file names

	if ! (javac -d . "${sources[@]}" 2> "$compileErr") ; then
		printf "Java (.java) Compilation Errors:\n"
		cat compile.err

		printf "Java (.java Compilation Errors:\n" 1> "$result"

		exit 1
	fi
	if [ ! -s "$compileErr" ] ; then
 		 rm "$compileErr"
	fi

	for i in "${sources[@]}"; do
		if [ ! -f "$(basename "$i" .java).class" ]; then
			printf "Error - Files named inccorectly. Java file names should be named after the class contained (case sensitive)\n"
			exit 1
		fi
	done

	printf "lang=java\nsources=(${sources[*]})" 1> "run.dat"
	cd ../../../..
	if [ $autograde == "interactive" ]; then
		source GradeInteractiveJava.sh 
	elif [ $autograde == "static" ]; then
		source GradeStaticJava.sh
	fi



#RUN JAVA
elif [ $lang == "c" ] ; then
	if ! (gcc -o "$exacutable" "${sources[@]}" 2> "$compileErr")
	then
		printf "C Compilation Errors:\n"
		printf "C Compilation Errors:\n" 1> "$result"
		cat compile.err
		exit 1
	fi
	if [ ! -s "$compileErr" ] ; then
 		 rm "$compileErr"
	fi

	printf "lang=c\nsources=(${sources[*]})" 1> "run.dat"
	cd ../../../..

	if [ $autograde == "interactive" ]; then
		source GradeInteractiveExe.sh
	elif [ $autograde == "static" ]; then
		source GradeStaticExe.sh
	fi


#RUN C
elif [ $lang == "cpp" ] ; then
	if ! (g++ -o "$exacutable" "${sources[@]}" 2> "$compileErr") ; then
		printf "C++ Compilation Errors:\n"
		printf "C++ Compilation Errors:\n" 1> "$result"
		cat compile.err
		
		exit 1
	fi
	if [ ! -s "$compileErr" ] ; then
 	 rm "$compileErr"
	fi


	printf "lang=cpp\nsources=(${sources[*]})" 1> "run.dat"
	cd ../../../..

	if [ $autograde == "interactive" ]; then
		source GradeInteractiveExe.sh
	elif [ $autograde == "static" ]; then
		source GradeStaticExe.sh
	fi
#RUN C++

elif [ $lang == "py" ] ; then

	printf "lang=py\nsources=(${sources[*]})" 1> "run.dat"
	cd ../../../..

	if [ $autograde == "interactive" ]; then
		source GradeInteractivePy.sh
	elif [ $autograde == "static" ]; then
		source GradeStaticPy.sh
	fi

fi
