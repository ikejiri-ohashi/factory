#!/bin/bash
set -e

rm -f /factory/tmp/pids/server.pid

exec "$@"
