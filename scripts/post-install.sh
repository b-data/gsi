#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# According to https://www.debian.org/doc/debian-policy/ch-opersys.html#site-specific-programs
if [[ "$PREFIX" == "/usr/local" ]]; then
    if test -e /tmp/etc/staff-group-for-usr-local ; then
        cat /tmp/var/cache/gsi/$GIT_VERSION-dir.list \
          | sed "/\/share\/man/d" | sed "s|^|$FINALDIR|" \
          | xargs -n 10 chown root:staff

        cat /tmp/var/cache/gsi/$GIT_VERSION-dir.list \
          | sed "/\/share\/man/d" | sed "s|^|$FINALDIR|" \
          | xargs -n 10 chmod 2775
    fi
fi
