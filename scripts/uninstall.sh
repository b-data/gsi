#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# Git
if [[ -f "$FINALDIR$PREFIX/lib/git-core/git" ]]; then
  GIT_VERSION_OLD=`$FINALDIR$PREFIX/lib/git-core/git --version | sed -n \
    "s|git version \([[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\).*|\1|p"`

  if [[ -f "/tmp/var/cache/gsi/$GIT_VERSION_OLD.list" ]]; then
    cat /tmp/var/cache/gsi/$GIT_VERSION_OLD.list \
      | sed "s|^|$FINALDIR|" | xargs -n 10 rm -f
  fi
fi

# bash completion
if [[ -f "/tmp/usr/local/share/bash-completion/completions/git" ]]; then
  rm /tmp/usr/local/share/bash-completion/completions/git
fi
