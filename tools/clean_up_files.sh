#!/usr/local/bin/zsh

OUTPUT_DIR="/manpages/output"
MANDOC_OUTPUT_DIR="/manpages/output/mandoc"

FILE_LIST='broken_base.txt 
              broken_base.txt.bac 
              broken_refs.txt 
              broken_refs.txt.bac
              broken_contrib.txt 
              broken_contrib.txt.bac 
              broken_error_file.txt 
              combined_base_refs.txt 
              combined_base_refs.txt 
              combined_contrib_refs.txt 
              whatis_results.txt 
              whatis_results.txt.bac'

MANDOC_FILE_LIST='mandoc_style_errors.txt
                  mandoc_80characters_error.txt
                  mandoc_escape_sequence_error.txt
                  mandoc_newsentence_error.txt
                  mandoc_pargraph_error.txt
                  mandoc_fn_error.txt
                  mandoc_tn_error.txt
                  mandoc_missingtitles_error.txt
                  mandoc_paragraph_error.txt
                  mandoc_tabs_error.txt
                  mandoc_whitespace_error.txt'

echo "Cleaning up the output..."
find "${HOME}/${OUTPUT_DIR}" -type f -exec rm -rf {} \;
find "${HOME}/${MANDOC_OUTPUT_DIR}" -type f -exec rm -rf {} \;
