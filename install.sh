#!/bin/sh
echo "\033[0;94m╔════════════════════════════════╗\033[0m"
echo "\033[0;94m║\033[0m\033[0;94m Powerful Terminal Installation \033[0;94m║\033[0m"
echo "\033[0;94m╚════════════════════════════════╝\033[0m"
echo ""

userOS=
userfile=
userfilepath=

checkOS()
{
	echo "\033[0;93m* Are you on a (M)ac, (L)inux or (W)indows/Git Bash?\033[0m"
	read userOS

	userOS=$(echo $userOS | awk {'print tolower($0)'})

	case $userOS in
		m*)	userOS="Mac"
			echo "\033[0;92mOK, you are using Mac.\033[0m"
			;;

		l*)	userOS="Linux"
			echo "\033[0;92mOK, you are using Linux.\033[0m"
			;;

		w*)	userOS="Windows"
			echo "\033[0;92mOK, you are using Windows.\033[0m"
			;;

		*)	echo "\033[0;91mInvalid option. Try again.\033[0m"
			echo ""
			checkOS
			;;
	esac
}

checkFile()
{
	echo "\033[0;93m* What is your profile file? - (~/.bash_profile)\033[0m"
	read userfile

	if [[ $userfile = "" ]]; then
		userfile="~/.bash_profile"
		userfilepath=~/.bash_profile
	else
		userfilepath="${userfile/#"~"/$HOME}"
	fi

	if [[ ! -f $userfilepath ]]; then
		touch $userfilepath
	fi

	sed -i '' '/POWERFUL TERMINAL BEGIN/,/POWERFUL TERMINAL END/ d' $userfilepath
}

checkOS
checkFile

echo "\033[0;92mOK, installing...\033[0m"

sourcefile=

if [[ $userOS = "Mac" ]]; then
	sourcefile="bash_profile"
else
	sourcefile="bash_profile_linwin"
fi

old_IFS=$IFS
IFS=$'\n'

echo "#====================== POWERFUL TERMINAL BEGIN ======================#" >> $userfilepath
echo "#= do not remove this block if you want to update via install script =#" >> $userfilepath
echo "" >> $userfilepath

while read -r line; do    
    echo "$line" >> $userfilepath
done < $sourcefile

echo "" >> $userfilepath
echo "#= do not remove this block if you want to update via install script =#" >> $userfilepath
echo "#======================= POWERFUL TERMINAL END =======================#" >> $userfilepath

cp git-completion.sh ~/.git-completion.sh
cp git-parse-branch.sh ~/.git-parse-branch.sh

IFS=$old_IFS

echo ""
echo "\033[0;92mPowerful Terminal Installed\033[0m"
echo "\033[0;92mRun \033[0msource $userfile \033[0;92mto activate.\033[0m"
echo ""
