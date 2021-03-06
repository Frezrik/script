#!/bin/bash

for f in `find $1 -name "*.[ch]"`
do
	encode=`file $f`
	if [[ $encode == *ISO-8859* ]]
	 then
		echo "file = $f"
		echo "encode = $encode"	
		echo "mach ISO-8859, convert to utf-8."
		iconv -f GBK -t UTF-8 $f  -o ${f}_utf8	
		rm $f
		mv ${f}_utf8 $f
	fi
	
	#dos2unix $f
	##去除行末的空格与制表符
	#sed  's/[ \t]*$//g' <$f  > ${f}_f1
	#mv ${f}_f1 $f

done
