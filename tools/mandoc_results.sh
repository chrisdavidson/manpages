#!/bin/sh

find /usr/src -name '*.[0-9]' -type f | xargs mandoc -Tlint  > /home/chrisdavidson/manpages/output/mandoc_style_errors.txt

