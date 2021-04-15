#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# Git
cp -a $DESTDIR/* $FINALDIR/

# Export list of installed files
find $DESTDIR \( -type f -o -type l \) -printf '/%P\n' \
  > /tmp/var/cache/gsi/$GIT_VERSION.list

# bash completion
install -m0644 \
  $FINALDIR$PREFIX/share/doc/git/contrib/completion/git-completion.bash \
  /tmp/usr/local/share/bash-completion/completions/git

install -m0644 \
  $FINALDIR$PREFIX/share/doc/git/contrib/completion/git-prompt.sh \
  $FINALDIR$PREFIX/lib/git-core/git-sh-prompt
echo "$PREFIX/lib/git-core/git-sh-prompt" \
  >> /tmp/var/cache/gsi/$GIT_VERSION.list
rm -rf $FINALDIR$PREFIX/share/doc/git/contrib/completion

if [[ ! -f "/tmp/etc/bash_completion.d/git-prompt" ]]; then
  sed -i "s|PREFIX|$PREFIX|g" /var/tmp/git-prompt
  install -m0644 /var/tmp/git-prompt /tmp/etc/bash_completion.d/git-prompt
fi
