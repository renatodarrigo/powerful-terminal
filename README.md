#Powerful terminal

Always beta.

With features by:

- Shawn O. Pearce <spearce@spearce.org>;
- Joe Fleming <https://twitter.com/w33ble>

And thanks to:

- Marcelo Carneiro <https://github.com/mcarneiro> for showing me the git completion and branch parsing stuff;
- Fernando Nunes <https://github.com/gnomonunes> for feedback about features and bugs.

##Screenshot

![Screenshot](screenshot.png)

##Features

- Displays the time when actual prompt was called;
- Folder full path with item count and size count;
- Git commands completion;
- Git branch display with icons for different statuses;
- Color alert when in master so you don't go crazy commiting changes in production code.

##Warning

Tested on Mac.

Linux / Windows (Git Bash) might need some tweaks.


##Automatic Install

1. Run `./install.sh`
2. Reload .bash_profile with `source ~/.bash_profile`

##Manual Install

1. Move the files to your home directory
2. Rename the files to be hidden:
`mv bash_profile .bash_profile`
`mv git-completion.sh .git-completion.sh`
`mv git-parse-branch.sh .git-parse-branch`
3. Reload .bash_profile
`source ~/.bash_profile`

Enjoy!