#!/bin/bash

ensure_dir () {
    if ! [ -d "$1" ]; then
        mkdir -p -- "$1" || fail "couldn't create $1"
    fi
}

fail () {
	echo "$@" >&2
	exit 1
}

for repo in $@; do
    ensure_dir "$HOME/$repo.git"
    cd "$HOME/$repo.git"
    git init --bare
done
