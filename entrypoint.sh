#!/bin/bash
set -e

rm -f /mangabestgram/tmp/pids/server.pid

exec "$@"
