#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

cd /tmp \
  && curl -sSLO \
    https://github.com/git/git/archive/refs/tags/v$GIT_VERSION.tar.gz \
  && tar -zxf v$GIT_VERSION.tar.gz \
  && cd git-$GIT_VERSION \
  && make configure \
  && ./configure \
    --prefix=$PREFIX \
    --libexecdir=$PREFIX/lib \
  && make all doc info strip \
  && sudo -E make install install-doc install-html install-info
