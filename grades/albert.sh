# Author: Avery Whitaker
# averywhitaker@gmail.com
# please respect license

# bash albert gradefile gradefolder

function compare {
	if diff -q $1 $2 > /dev/null ; then
			return 0
		else		
			echo "Does not match expected output"
			diff $1 $2
			return 1
	fi
}

#run inputfile outputfile
function run {
	case $lang in
		cpp )
			timeGiven=4
			timeout $timeGiven ./cppprogram>output<$1 2> runtime.err ;;
		java )
			timeGiven=8
			timeout $timeGiven java ${source:3:-5}>output<$1 2> runtime.err ;;
		python )
			timeGiven=8
			timeout $timeGiven python $source>output<$1 2> runtime.err ;;
		c )
			timeGiven=4
			timeout $timeGiven ./cprogram>output<$1 2> runtime.err ;;
	esac
	
	execrtrn=$?

	if [ $execrtrn == "124" ] ; then
		echo "Error: Program Took too long ($timeGiven seconds)"
		return 1
	elif [ $execrtrn == "1" ] ; then
		echo "Runtime Errors:"
		cat runtime.err
	else
		#echo "Program Ran Successfully (Returning "$execrtrn")"

		compare output $2
		return $?
	fi
}

#set -x

folderID=1

while ! mkdir $folderID 2> /dev/null  ; do
	folderID=$(($folderID+1))
done

cd $folderID

source=../$1
gradefolder=$2

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
	echo "Error- File type not supported: Must be .py, .c, .cpp, .java"
	exit 1
fi

if [ $lang == "java" ] ; then
	if ! (javac -d . $source 2> compile.err) ; then
		echo "Java Compilation Errors:"
		cat compile.err
	fi
fi

if [ $lang == "c" ] ; then
	if ! (gcc -o ./cprogram $source 2> compile.err)
	then
		echo "C Compilation Errors:"
		cat compile.err
	fi
fi

if [ $lang == "cpp" ] ; then
	if ! (g++ -o ./cppprogram $source 2> compile.err) ; then
		echo "C++ Compilation Errors:"
		cat compile.err
	fi
fi

for dir in $gradefolder/* ; do 
	echo "--- Test `echo $dir| cut -d'/' -f2-` ---"
	run $dir/in $dir/out
	echo $?
done
	
cd ..
rm -r $folderID
