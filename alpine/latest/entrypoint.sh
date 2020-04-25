#!/bin/sh
#
# Copyright (C) 2020 James Fuller <jim.fuller@webcomposite.com>
#
# SPDX-License-Identifier: MIT
#

set -e

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- curl "$@"
fi

exec "$@"
