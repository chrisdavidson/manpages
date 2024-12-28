#!/bin/sh

MANDOC_STYLE="${HOME}/manpages/output/mandoc_style_errors.txt"
MANDOC_LOCATION="/usr/share/man"
STYLE="${HOME}/manpages/output/style_errors.txt"
WARNINGS="${HOME}/manpages/output/warning_errors.txt"
HEADER="CATEGORY  SECTION NAME  LOCATION  DESCRIPTION"

echo "Finding all the manual pages."
find "${MANDOC_LOCATION}" -type f -exec mandoc -T lint {} \; > "${MANDOC_STYLE}" 
echo "Finding warnings and style errors."
echo $HEADER > $STYLE
echo $HEADER > $WARNINGS

awk -f mandoc_results.awk "${MANDOC_STYLE}"
