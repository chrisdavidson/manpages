#!/usr/local/bin/zsh

find /usr/share/man -type f -name '*gz' | \
  xargs zgrep -H . |                      \
  awk -f check_man_pages.awk |            \
  sort |                                  \
  tee /home/chrisdavidson/manpages/output/broken_refs.txt
