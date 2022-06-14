#!/bin/bash
# Copyright (c) 2021 b-data GmbH.
# Distributed under the terms of the MIT License.

set -e

# Test if PREFIX location is whithin limits
if [[ ! "${PREFIX}" == "/usr/local" && ! "${PREFIX}" =~ ^"/opt" ]]; then
  echo "ERROR:  PREFIX set to '${PREFIX}'. Must either be '/usr/local' or within '/opt'."
  exit 1
fi

if [[ "${MODE}" == "install" ]]; then
  # Temp install to $DESTDIR$PREFIX
  build.sh

  # Modify installation at temp
  modify.sh

  # Uninstall old Git version
  uninstall.sh

  # Install to $FINALDIR
  install.sh
fi

if [[ "${MODE}" == "uninstall" ]]; then
  # Uninstall old Git version
  uninstall.sh
fi
