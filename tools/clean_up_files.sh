#!/bin/sh

OUTPUT_DIR="/manpages/output"
MANDOC_OUTPUT_DIR="/manpages/output/mandoc"

echo "Cleaning up the output..."
find "${HOME}/${OUTPUT_DIR}" -type f -exec rm -rf {} \;
find "${HOME}/${MANDOC_OUTPUT_DIR}" -type f -exec rm -rf {} \;
