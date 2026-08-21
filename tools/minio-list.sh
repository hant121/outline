#!/bin/sh
set -e
mc alias set local https://minio:9000 minioadmin minioadmin --insecure >/dev/null
mc ls -r local/outline --insecure | head -8
echo "COUNT=$(mc ls -r local/outline --insecure | wc -l)"
