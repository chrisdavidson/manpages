#!/bin/sh

OUTPUT_DIR="${HOME}/manpages/output"

echo "cleaning up files.."
sh clean_up_files.sh
echo "working through mandoc -Tlint..."
sh mandoc_results.sh
echo "parsing manual pages..."
sh check_pages.sh
echo "processing results of manual pages.."
perl parse_broken_refs.pl
echo "post-processing output files..."
cp "${OUTPUT_DIR}"/broken_refs.txt "${OUTPUT_DIR}"/broken_refs.txt.bac
cat "${OUTPUT_DIR}"/broken_refs.txt.bac | tr -s '[:space:]' > "${OUTPUT_DIR}"/broken_refs.txt
echo "combine results..."
perl combine_outputs.pl
echo "working through whatis ..."
perl check_whatis.pl
