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

[includeIf "gitdir:bandwidth/"]
    path = .gitconfig-work
EOF

cat << EOF > ~/.gitconfig-home
[user]
  email = github@jake8us.org
EOF

cat << EOF > ~/.gitconfig-work
[user]
  email = smingolelli@bandwidth.com
EOF
