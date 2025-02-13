#!/bin/bash

## Unit tests for rename.sh
##
## At the moment, requires manual checking.
##
## Needs automation.


echo "This script MUST be run in an empty directory because"
echo "it will erase all files when it runs."
read -p "Ok (y/N)? " -N 1 -t 5 -i "n" userInput


if [[ ${userInput} != "y" && ${userInput} != "Y" ]]; then
	echo
	exit
fi

echo "For now, this file is for manually checking results."
echo "Automation will be implemented later."
exit 1


touch file1.text
touch file1b.text
touch file2.text




## ##################################################################
## INCORRECT / WRONG results:
## ##################################################################

## Next should now be fixed:

~/utils/rename.sh -nvv  *.text *g.htm
replace_pattern STARTS with star:
NOOP mv --no-clobber --verbose  file1b.text file1b.g.htm
^^ NOW FIXED




~/utils/rename.sh -nvv  *.text g*.htm
ERROR: can't figure out what to do with the wildcard in 
"g*.htm" due to its location within string.
What is it replacing within file "file1b.text"?




~/utils/rename.sh -nvv  "*.text" g*.htm
NOOP mv --no-clobber --verbose  file1b.text file1b.htm




~/utils/rename.sh -vvvn "*.gzz" "*"
NOOP mv --no-clobber --verbose  file.tar.gzz file.tar



~/utils/rename.sh -vvvn *.gzz "backup.*.gzip"
ERROR: can't figure out what to do with the wildcard in 
"backup.*.gzip" due to its location within string.
What is it replacing within file "file.tar.gzz"?


## This isn't what I intended, but neither is it exactly WRONG:
~/utils/rename.sh -vvvn "*.gzz" "backup.*.gzip"
NOOP mv --no-clobber --verbose  file.tar.gzz backup.file.tar.gzip


 ~/utils/rename.sh -vvvn *.gzz "*backup.*."
replace_pattern STARTS with star:
NOOP mv --no-clobber --verbose  file.tar.gzz file.tarbackup.*.


## Not even sure WHAT this should result in:
~/utils/rename.sh -vvvn "f*e*.text" *iill*.txt
Iterating through file list: "f*e*.text"
search="f" and replace="" and kounter=0 and myNewFile=file1b.text
search="e" and replace="iill" and kounter=1 and myNewFile=ile1b.text
search=".text" and replace=".txt" and kounter=2 and myNewFile=iliill1b.text
NOOP mv --no-clobber --verbose  file1b.text iliill1b.txt


## But this (same as previous minus quotes) should NOT result in "*" in result:
~/utils/rename.sh -vvvn f*e*.text *iill*.txt
replace_pattern STARTS with star: *iill*.txt
NOOP mv --no-clobber --verbose  file1b.text file1biill*.txt




## ##################################################################
## CORRECT / ANTICIPATED results:
## ##################################################################


~/utils/rename.sh -nvv  "*.*[lt]" *.htm
NOOP mv --no-clobber --verbose  file1b.text file1b.htm



~/utils/rename.sh -nvv  *.text *.htm
replace_pattern STARTS with star:
NOOP mv --no-clobber --verbose  file1b.text file1bg.htm



~/utils/rename.sh -vvvn "*.gzz" "*.gzip"
NOOP mv --no-clobber --verbose  file.tar.gzz file.tar.gzip


~/utils/rename.sh -vvvn *.gzz "backup.*.*"
NOOP mv --no-clobber --verbose  file.tar.gzz backup.tar.gzz

