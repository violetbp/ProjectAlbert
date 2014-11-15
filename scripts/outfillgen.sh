#bash fillgen.sh inputfile folder

#prepares exacutable for use by outfill.sh

#run inputfile outputfile

function cleanup {

if [ $1 == 0 ] ; then
echo "Correct"
fi

cd ..
rm -r $folderID
exit $1
}

set -x


folder=../$2
source=../$1

temp="TEMP"
folderID=1
while ! mkdir $temp$folderID 2> /dev/null; do
	folderID=$(($folderID+1))
done
folderid = $temp$folderid

cd $folderID


if [ $source == "" ] ; then
	echo "Error- No file submitted: Must be .py, .c, .cpp, .java"
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
	echo "Error- File type not supported: Must be .py, .c, .cpp, .java"
	cleanup 1
fi

if [ $lang == "java" ] ; then
	if ! (javac -d . $source 2> compile.err) ; then
		echo "Java Compilation Errors:"
		cat compile.err
		cleanup 1
	else
    mv ./$source folder/$source
  fi
fi

if [ $lang == "c" ] ; then
	if ! (gcc -o ./outgenc $source 2> compile.err)
	then
		echo "C Compilation Errors:"
		cat compile.err
		cleanup 1
	else
    mv ./outgenc folder/outgenc
  fi
fi

if [ $lang == "cpp" ] ; then
	if ! (g++ -o ./outgencpp $source 2> compile.err) ; then
		echo "C++ Compilation Errors:"
		cat compile.err
		cleanup 1
	else
    mv ./outgencpp folder/outgencpp
  fi
fi

outfill folder
cleanup 0
