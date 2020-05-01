#!/bin/bash
service netdata start
. /usr/local/bin/docker-entrypoint.sh "$@"
_main "$@"