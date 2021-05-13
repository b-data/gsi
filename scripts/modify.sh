#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# install contrib stuff
find /tmp/git-$GIT_VERSION/contrib -name '.git*' -delete
cp -a --no-preserve=ownership /tmp/git-$GIT_VERSION/contrib \
  $DESTDIR$PREFIX/share/doc/git/

# move and symlink hooks
mkdir -p $DESTDIR$PREFIX/share/git-core/contrib/
mv $DESTDIR$PREFIX/share/doc/git/contrib/hooks \
  $DESTDIR$PREFIX/share/git-core/contrib/

ln -rs $DESTDIR$PREFIX/share/git-core/contrib/hooks \
  $DESTDIR$PREFIX/share/doc/git/contrib/hooks
