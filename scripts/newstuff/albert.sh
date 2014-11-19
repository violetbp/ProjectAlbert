

# Author: Avery Whitaker
# averywhitaker@gmail.com

# bash albert gradefile gradefolder scriptsDir

function compare {
	if diff -q --strip-trailing-cr -B -Z $1 $2 > /dev/null ; then
			#echo "Correct!"
			return 0
		else		
			echo "Does not match expected output"
		#	diff -y --strip-trailing-cr -B -Z -W 30 $1 $2
	printf "Your output\n"
      cat $1
      printf "Expected Output\n"
      cat $2
		printf "\n"
			return 1
	fi
}

#run inputfile outputfile
function run {
	case $lang in
		cpp )
			timeGiven=4
			memGiven=640000
			  $memtimelimit -t $timeGiven -m  $memGiven sandbox ./cppprogram>output<$1 2> runtime.err ;;
		java )
			timeGiven=6
			memGiven=640000
			Xmx="-Xmx"
			m="m"
      #TODO dosnt return error code if cant find main class
			   $memtimelimit -t $timeGiven sandbox java $Xmx$memGiven$m -Xms8m $(basename $source .java)>output<$1 2> runtime.err ;;
		python )
			timeGiven=8
			memGiven=640000
			  $memtimelimit -t $timeGiven  -m $memGiven sandbox python $source>output<$1 2> runtime.err ;;
		c )
			timeGiven=4
			memGiven=640000
			  $memtimelimit -t $timeGiven  -m $memGiven sandbox ./cprogram>output<$1 2> runtime.err ;;
	esac
	
	execrtrn=$?
#echo $execrtrn
	if [ $execrtrn == "128" ] ; then
		cat runtime.err
		return 1
	elif [ $execrtrn == "1" ] ; then
		echo "Runtime Errors:"
		cat runtime.err
		return 1
	elif [ $execrtrn == "0" ] ; then
		#echo "Program Ran Successfully (Returning "$execrtrn")"

		#cat runtime.err
		compare output $2
		return $?
	else
		printf "Unknown Error: "
		printf $execrtrn
		printf "\n"
		cat runtime.err
		return 1
	fi
}

function cleanup {

if [ $1 == 0 ] ; then
printf "Correct\n"
fi

cd ..
rm -rf $folderID
exit $1
}

#set -x


gradefolder=../$2
source=../$1

temp="/memtimelimit.sh"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
memtimelimit=$DIR$temp


temp="TEMP"
folderID=1
while ! mkdir $temp$folderID 2> /dev/null  ; do
	folderID=$(($folderID+1))
done
folderID=$temp$folderID

cd $folderID

if [ $source == "" ] ; then
	printf "Error- No file submitted: Must be .py, .c, .cpp, .java\n"
	cleanup 1
fi

lang="null"
if [[ ${source: -4} == ".cpp" ]] ; then
	lang="cpp"
elif [[ ${source: -2} == ".c" ]] ; then
	lang="c"
elif [[ ${source: -5} == ".java" ]] ; then
	lang="java"
elif [[ ${source: -3} == ".py" ]] ; then
	lang="python"
fi

if [ $lang == "null" ] ; then
	printf "Error- File type not supported: Must be .py, .c, .cpp, .java\n"
	cleanup 1
fi

#THINGS TO DO
#Remove Pacage defeimtions
#rename class to file name
#handle multiple files
#make compileing safe
if [ $lang == "java" ] ; then
	if ! (javac -d . $source 2> compile.err) ; then
		printf "Java (.java) Compilation Errors:\n"
		cat compile.err
		cleanup 1
	fi
fi

if [ $lang == "c" ] ; then
	if ! (gcc -o ./cprogram $source 2> compile.err)
	then
		printf "C Compilation Errors:\n"
		cat compile.err
		cleanup 1
	fi
fi

if [ $lang == "cpp" ] ; then
	if ! (g++ -o ./cppprogram $source 2> compile.err) ; then
		printf "C++ Compilation Errors:\n"
		cat compile.err
		cleanup 1
	fi
fi

#this was broken
for set in $gradefolder/* ; do 
	#echo "--- Test `echo $dir| cut -d'/' -f2-` ---"
  
  #make ignore gen program
	run $set/in $set/out
	if [ $? == 1 ] ; then
		cleanup 1
	fi
done
	
cleanup 0

