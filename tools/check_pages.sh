#!/usr/local/bin/zsh

MAN_DIR="${HOME}/src/manuals"
find "${MAN_DIR}" -type f -name '*gz' | \
  xargs zgrep -H . |                      \
  awk -f check_man_pages.awk |            \
  sort |                                  \
  tee /home/chrisdavidson/manpages/output/broken_refs.txt
