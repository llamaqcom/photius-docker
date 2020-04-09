#!/usr/bin/env bash

while true
do
  echo "[$(date +%s.%N)] Scanning for new files."
  echo $(date +%s) > /tmp/healthcheck

  # We do not process hidden files or files with non-standard filename format
  # as lots of sync/upload applications use hidden files (i.e. syncthing or webdav).
  # For the same reason, just to be sure, we want to be sure each file to be
  # at least one minute old in our local filesystem before we process it.

  find "$SRC_DIR" -type f -cmin +1 -iname '*.*' ! -iname '.*' \
    -exec sleep 1.5 \; -exec /usr/local/bin/photius-helper.sh "{}" \;

  echo "[$(date +%s.%N)] Scan completed."
  sleep 12
done
