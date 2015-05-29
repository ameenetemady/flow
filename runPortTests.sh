#!/bin/bash
# This script ports the files under the "tests/port" directory and checks them agains the related .exp file
fileList=`ls tests/port/*.js`
diffStatus='diffStatus_asdfa.tmp'

for i in $fileList
do
  actual="${i}_asdfa.tmp"
  expected=" ${i}.exp"
  ./bin/flow port $i | tail -n +2 > $actual #first line should be skipped, because it's sensitive to the path
  diff -u $actual $expected > $diffStatus
  
  if [ -s $diffStatus ]
  then
    echo -e  "\e[4mFAIL\e[24m ${i}"
  else
    echo PASS $i
  fi
  rm -f $actual $diffStatus
done
