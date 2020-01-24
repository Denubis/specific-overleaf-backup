#!/bin/bash

set -euo pipefail

mkdir -p data

for line in $(cat papersToBackup.txt)
do
repo=$( echo "$line" | cut -d'/' -f4 -)
if [ ! -d "data/$repo/.git" ]; then
	git -C data clone "$line"
	echo "Please enter the github url of this repository"
	read githuburl
	cd "data/$repo"
	git remote add github "$githuburl"
	git pull github master
	git push github master
else
	echo "Repo ${repo} exists, updating"
	cd "data/$repo"
	git pull github master
	git pull
	git push github master
fi
done
