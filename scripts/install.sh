#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# Git
cp -a $DESTDIR/* $FINALDIR/

# Export list of installed files
find $DESTDIR \( -type f -o -type l \) -printf '/%P\n' \
  > /tmp/var/cache/gsi/$GIT_VERSION-file.list

# Export list of installed directories
find $DESTDIR$PREFIX \( -type d \) -printf '/%P\n' \
  > /tmp/var/cache/gsi/$GIT_VERSION-dir.list
sed -i -E "/^\/(bin|lib|share|share\/man)?$/d" \
  /tmp/var/cache/gsi/$GIT_VERSION-dir.list
sed -i "s|^|$PREFIX|" /tmp/var/cache/gsi/$GIT_VERSION-dir.list

# bash completion
mkdir -m 2775 -p /tmp/usr/local/share/bash-completion
mkdir -m 2775 -p /tmp/usr/local/share/bash-completion/completions
install -m0644 \
  $FINALDIR$PREFIX/share/doc/git/contrib/completion/git-completion.bash \
  /tmp/usr/local/share/bash-completion/completions/git

install -m0644 \
  $FINALDIR$PREFIX/share/doc/git/contrib/completion/git-prompt.sh \
  $FINALDIR$PREFIX/lib/git-core/git-sh-prompt
echo "$PREFIX/lib/git-core/git-sh-prompt" \
  >> /tmp/var/cache/gsi/$GIT_VERSION-file.list
sed -i "\/share\/doc\/git\/contrib\/completion$/d" \
  /tmp/var/cache/gsi/$GIT_VERSION-dir.list
rm -rf $FINALDIR$PREFIX/share/doc/git/contrib/completion

if [[ ! -d "/tmp/etc/bash_completion.d" ]]; then
  mkdir /tmp/etc/bash_completion.d

  if [[ ! -f "/tmp/etc/bash_completion.d/git-prompt" ]]; then
    sed -i "s|PREFIX|$PREFIX|g" /var/tmp/git-prompt
    install -m0644 /var/tmp/git-prompt /tmp/etc/bash_completion.d/git-prompt
  fi
fi
