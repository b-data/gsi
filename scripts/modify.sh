#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# install contrib stuff
find /tmp/git-$GIT_VERSION/contrib -name '.git*' -delete
cp -R /tmp/git-$GIT_VERSION/contrib \
  $DESTDIR$PREFIX/share/doc/git/
