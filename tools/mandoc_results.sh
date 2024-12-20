#!/bin/sh

MANDOC_STYLE="${HOME}/manpages/output/mandoc/mandoc_style_errors.txt"
MANDOC_LOCATION="/usr/share/man"

echo "Finding all the manual pages..."
find "${MANDOC_LOCATION}" -type f -exec mandoc -T lint {} \; > "${MANDOC_STYLE}" 

echo "Finding entires with more than 80 characters..."
cat "${MANDOC_STYLE}" | grep "longer than 80" > ../output/mandoc/mandoc_80characters_error.txt

echo "Finding issues with .Fn entries..."
cat "${MANDOC_STYLE}" | grep "Fn" > ../output/mandoc/mandoc_fn_error.txt

echo "Finding issues with ueless macro .Tn..."
cat "${MANDOC_STYLE}" | grep "useless macro: Tn" >> ../output/mandoc/mandoc_tn_error.txt

echo "Finding missing manual titles.."
cat "${MANDOC_STYLE}" | grep "missing manual title" > ../output/mandoc/mandoc_missingtitles_error.txt

echo "Finding new sentence style errors.."
cat "${MANDOC_STYLE}" | grep "new sentence" > ../output/mandoc/mandoc_newsentence_error.txt

echo "Finding whitespace at end of lines.."
cat "${MANDOC_STYLE}" | grep "whitespace at end" > ../output/mandoc/mandoc_whitespace_error.txt

echo "Finding tab in filed text errors..."
cat "${MANDOC_STYLE}" | grep "tab in filled" > ../output/mandoc/mandoc_tabs_error.txt

echo "Finding invalid escape sequence errors..."
cat "${MANDOC_STYLE}" | grep "invalid escape sequence" > ../output/mandoc/mandoc_escape_sequence_error.txt

echo "Finding invalid paragraph macrco PP after SS.."
cat "${MANDOC_STYLE}" | grep "skipping paragraph macro" > ../output/mandoc/mandoc_paragraph_error.txt
