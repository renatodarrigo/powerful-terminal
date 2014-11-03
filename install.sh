#!/bin/sh

old_IFS=$IFS
IFS=$'\n'

echo "" >> ~/.bash_profile
echo "#======= POWERFUL TERMINAL =======#" >> ~/.bash_profile

while read line; do    
    echo $line >> ~/.bash_profile   
done < bash_profile

cp git-completion.sh ~/.git-completion.sh
cp git-parse-branch.sh ~/.git-parse-branch.sh

IFS=$old_IFS

echo "Powerful Terminal Installed"
echo "Run 'source ~/.bash_profile' to activate."
