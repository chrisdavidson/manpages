#!/bin/sh

OUTPUT_DIR="${HOME}/manpages/output"
MAN_DIR="/usr/share/man"

find "${MAN_DIR}" -type f -name '*gz' | \
  xargs zgrep -H . |                      \
  awk -f check_man_pages.awk |            \
  sort |                                  \
  tee "${OUTPUT_DIR}/broken_refs.txt"
