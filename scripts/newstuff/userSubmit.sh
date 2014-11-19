OUT OF DATE

#bash userSubmit.sh userID problemID language sourceFile1 sourceFile2...

#
 
set -x
userID=$1
problemID=$2
lang=$3 #langs supported: cpp, c, java, python
shift 3
if [ "$#" -eq 0 ]; then
	printf "Error- No source files provided\n"
	exit 1
else
  sources=( "$@" )
fi

result="resault.dat"
runtimeErr="runtime.err"
compileErr="compile.err"
exacutable="exe"
graderData="graderData.dat"
#submissionID=$(date)
submissionID=1

mkdir "Users/${userID}/${problemID}/${submissionID}"

for i in "${sources[@]}"; do
cp "$i" "Users/${userID}/${problemID}/${submissionID}/${i}"
done

cd "Users/${userID}/${problemID}/${submissionID}"


#Ruby should not let this happen
if [ $lang != "java" ] && [ $lang != "cpp" ] && [ $lang != "c" ] && [ $lang != "py" ]; then
	printf "Error- Langauge not supported: Must be .py, .c, .cpp, .java\n"
	exit 1
fi

#TODO make compileing safe

if [ $lang == "java" ] ; then
#TODO: Deal with Package Declarations
#TODO Rename class to what we want
	if ! (javac -d . "${sources[@]}" 2> "$compileErr") ; then
		printf "Java (.java) Compilation Errors:\n"
		cat compile.err

		prinf "Java (.java Compilation Errors:\n" 1> "$result"

		exit 1
	fi
	if [ ! -s "$compileErr" ] ; then
 		 rm "$compileErr"
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
#RUN C++

fi

#Compile
#Grade
