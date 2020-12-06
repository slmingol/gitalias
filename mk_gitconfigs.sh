#!/bin/bash

# g* tools via brew install coreutils
[ $(uname) == "Darwin" ] && readlink=greadlink || readlink=readlink

ln -fs $(dirname $($readlink -f $0))/gitalias.txt ~/.gitalias.txt

cat << EOF > ~/.gitconfig
[include]
    path = ~/.gitalias.txt

# Enforce SSH
[url "ssh://git@github.com/"]
    insteadOf = https://github.com/

# select appropriate gitconfig based on path/dir used
#
[includeIf "gitdir:projects/"]
    path = .gitconfig-home

[includeIf "gitdir:.bash_profile.d/"]
    path = .gitconfig-home

[includeIf "gitdir:bandwidth/"]
    path = .gitconfig-work
EOF

# home
git config --file=$HOME/.gitconfig-home --replace-all user.email github@jake8us.org
git config --file=$HOME/.gitconfig-home --replace-all user.name slmingol

# work
git config --file=$HOME/.gitconfig-work --replace-all user.email smingolelli@bandwidth.com
git config --file=$HOME/.gitconfig-work --replace-all user.name slmingol
