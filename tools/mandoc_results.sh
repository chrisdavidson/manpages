#!/bin/sh

MANDOC_STYLE="${HOME}/manpages/output/mandoc/mandoc_style_errors.txt"
MANDOC_LOCATION="/usr/share/man"

echo "Finding all the manual pages..."
find "${MANDOC_LOCATION}" -type f -exec mandoc -T lint {} \; > "${MANDOC_STYLE}" 
awk -f mandoc_results.awk "${MANDOC_STYLE}"
