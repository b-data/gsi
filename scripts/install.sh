#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# According to https://www.debian.org/doc/debian-policy/ch-opersys.html#site-specific-programs
if [[ "$PREFIX" == "/usr/local" && -e /tmp/etc/staff-group-for-usr-local ]]; then
  perm=2775
  group=staff
else
  perm=755
  group=root
fi

# Export list of installed files
find $DESTDIR \( -type f -o -type l \) -printf '/%P\n' \
  > /tmp/var/cache/gsi/$GIT_VERSION-file.list

# Export list of installed directories
find $DESTDIR$PREFIX \( -type d \) -printf '/%P\n' \
  > /tmp/var/cache/gsi/$GIT_VERSION-dir.list
sed -i -E "/^\/(bin|lib|share|share\/man)?$/d" \
  /tmp/var/cache/gsi/$GIT_VERSION-dir.list
sed -i "s|^|$PREFIX|" /tmp/var/cache/gsi/$GIT_VERSION-dir.list

# Git
mkdir -p $FINALDIR$PREFIX/{bin,lib,share,share/man}
cat /tmp/var/cache/gsi/$GIT_VERSION-dir.list \
  | sed "s|^|$FINALDIR|" | xargs -n 10 mkdir -m$perm -p
cat /tmp/var/cache/gsi/$GIT_VERSION-dir.list \
  | sed "s|^|$FINALDIR|" | xargs -n 10 chown root:$group
cp -R $DESTDIR/* $FINALDIR/

# bash completion
mkdir -m$perm -p /tmp/usr/local/share/bash-completion
chown root:$group /tmp/usr/local/share/bash-completion
mkdir -m$perm -p /tmp/usr/local/share/bash-completion/completions
chown root:$group /tmp/usr/local/share/bash-completion/completions
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
