#!/bin/sh

OUTPUT_DIR="/manpages/output"

echo "Cleaning up the output..."
find "${HOME}/${OUTPUT_DIR}" -type f -exec rm -rf {} \;
