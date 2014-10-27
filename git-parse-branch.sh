#!/bin/bash

# @see: http://joefleming.net/posts/git-info-in-your-bash-prompt/

function git-parse-branch {
    git rev-parse --git-dir > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        git_status="$(git status 2> /dev/null)"
        branch_pattern="^On branch ([^${IFS}]*)"
        detached_branch_pattern="Not currently on any branch"
        remote_pattern="Your branch is (.*) of"
        diverge_pattern="Your branch and (.*) have diverged"
        untracked_pattern="Untracked files:"
        new_pattern="new file:"
        not_staged_pattern="Changes not staged for commit"
        deleted_pattern="deleted:"

        #files not staged for commit
        if [[ ${git_status}} =~ ${not_staged_pattern} ]]; then

            # files deleted local
            if [[ ${git_status} =~ ${deleted_pattern} ]]; then
                state="\[\033[0;91m\]✘\[\033[0m\]"
            else
                state="\[\033[0;96m\]?\[\033[0m\]"
            fi
        fi
        # add an else if or two here if you want to get more specific
        # show if we're ahead or behind HEAD
        if [[ ${git_status} =~ ${remote_pattern} ]]; then
            if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
                remote="\[\033[0;92m\]↑\[\033[0m\]"
            else
                remote="\[\033[0;91m\]↓\[\033[0m\]"
            fi
        fi
        #new files
        if [[ ${git_status} =~ ${new_pattern} ]]; then
            remote="\[\033[0;93m\]+\[\033[0m\]"
        fi
        #untracked files
        if [[ ${git_status} =~ ${untracked_pattern} ]]; then
            remote="\[\033[0;93m\]*\[\033[0m\]"
        fi
        #diverged branch
        if [[ ${git_status} =~ ${diverge_pattern} ]]; then
            remote="\[\033[0;91m\]↕\[\033[0m\]"
        fi
        #branch name
        if [[ ${git_status} =~ ${branch_pattern} ]]; then
	    branch_name=${BASH_REMATCH[1]}
	    if [[ ${branch_name} == "master" ]]; then
	        branch="\[\033[0;97;41m\](master)\[\033[0m\]"
	    else
	        branch="\[\033[0;96m\](${branch_name})\[\033[0m\]"
	    fi
        #detached branch
        elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
            branch="\[\033[0;91m\](NO BRANCH)\[\033[0m\]"
        fi

        echo "\[\033[0;90m\]║\[\033[00m\] ${branch}${state}${remote}"
    fi
    return
}
