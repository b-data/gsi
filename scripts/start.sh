#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# Temp install to $DESTDIR$PREFIX
build.sh

# Modify installation at temp
sudo -E modify.sh

# Uninstall old Git version
sudo -E uninstall.sh

# Install to $FINALDIR
sudo -E install.sh

# Set dir permissions
sudo -E post-install.sh
