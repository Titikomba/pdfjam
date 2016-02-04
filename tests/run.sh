#!/bin/sh
##
##  Just a few very basic tests for now.  This set of tests will grow and be 
##  refined as time permits.
##
ao='actual output'
test -d "$ao" || (mkdir "$ao" ; mkdir "$ao"/'PDF files' ; mkdir "$ao"/Prattled)
eo='expected output'
src='PDF sources'
bin=`pwd` ; bin="$bin"/../bin
PATH="$bin":"$PATH"
export PATH
##
## Test 1, with space in path to source file
##
echo 'RUNNING TEST 1...'
pdfjam --vanilla "$src"/'sub dir'/numbers-A4.pdf --nup 2x1 --frame true --landscape --outfile "$ao"/'PDF files'/test1.pdf 2> "$ao"/Prattled/temp.txt
sed 's+/.*pdfjam/tests/++' "$ao"/Prattled/temp.txt > "$ao"/Prattled/test1.txt
diffs=`diff "$eo"/Prattled/test1.txt "$ao"/Prattled/test1.txt`
if test -z "$diffs"; then echo OK; else echo "$diffs"; fi
##
## Test 2, with a space in the file name
##
echo 'RUNNING TEST 2...'
pdfjam --vanilla "$src"/'numbers A4.pdf' --paper letterpaper --nup 2x1 --frame true --landscape --suffix test2 --outfile "$ao"/'PDF files' 2> "$ao"/Prattled/temp.txt
sed 's+/.*pdfjam/tests/++' "$ao"/Prattled/temp.txt > "$ao"/Prattled/test2.txt
diffs=`diff "$eo"/Prattled/test2.txt "$ao"/Prattled/test2.txt`
if test -z "$diffs"; then echo OK; else echo "$diffs"; fi
##
## Test 3, pdfjam-pocketmod
##
echo 'RUNNING TEST 3...'
pdfjam-pocketmod "$src"/'numbers A4.pdf' --vanilla --outfile "$ao"/'PDF files'/test3.pdf 2> "$ao"/Prattled/temp.txt 
sed 's+/.*pdfjam/tests/++' "$ao"/Prattled/temp.txt > "$ao"/Prattled/test3.txt
diffs=`diff "$eo"/Prattled/test3.txt "$ao"/Prattled/test3.txt`
if test -z "$diffs"; then echo OK; else echo "$diffs"; fi
##
## Test 4, a batch job
##
echo 'RUNNING TEST 4...'
pdfjam --vanilla "$src"/'numbers A4.pdf' "$src"/'letters.pdf' 2,4,6,8 --nup 2x2 --batch --suffix test4 --outfile "$ao"/'PDF files' 2> "$ao"/Prattled/temp.txt
sed 's+/.*pdfjam/tests/++' "$ao"/Prattled/temp.txt > "$ao"/Prattled/test4.txt
diffs=`diff "$eo"/Prattled/test4.txt "$ao"/Prattled/test4.txt`
if test -z "$diffs"; then echo OK; else echo "$diffs"; fi
rm "$ao"/Prattled/temp.txt
##
## Test 5, pdfbook
##
echo 'RUNNING TEST 5...'
pdfbook --short-edge --preamble '%% Just a comment' --signature 4 --suffix test5 --vanilla "$src"/'numbers A4.pdf' --outfile "$ao"/'PDF files' 2> "$ao"/Prattled/temp.txt
sed 's+/.*pdfjam/tests/++' "$ao"/Prattled/temp.txt > "$ao"/Prattled/test5.txt
diffs=`diff "$eo"/Prattled/test5.txt "$ao"/Prattled/test5.txt`
if test -z "$diffs"; then echo OK; else echo "$diffs"; fi
rm "$ao"/Prattled/temp.txt