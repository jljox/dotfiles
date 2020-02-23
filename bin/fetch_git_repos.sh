#!/usr/bin/env bash

GIT_DIRS=`find . -type d -name .git`
wd=`pwd`
for gitdir in $GIT_DIRS
do
  dir=`dirname $gitdir`
  echo "cd into $dir"
  cd $dir && git fetch; cd $wd
done

