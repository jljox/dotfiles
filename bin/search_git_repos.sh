#!/usr/bin/env bash

GIT_DIRS=`find . -type d -name .git`
wd=`pwd`
for gitdir in $GIT_DIRS
do
  dir=`dirname $gitdir`
  cd $dir
  RESULT=`git --no-pager grep -il "$1"`
  if [ $? -eq 0 ]
  then
    echo ""; echo "$dir"
    echo $RESULT
  fi
  cd $wd
done

