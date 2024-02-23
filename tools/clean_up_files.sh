#!/usr/local/bin/zsh

OUTPUT_DIR="/manpages/output"

FILE_LIST='broken_base.txt 
              broken_base.txt.bac 
              broken_refs.txt 
              broken_contrib.txt 
              broken_contrib.txt.bac 
              broken_error_file.txt 
              combined_base_refs.txt 
              combined_base_refs.txt 
              combined_contrib_refs.txt 
              whatis_results.txt 
              whatis_results.txt.bac
              mandoc_style_errors.txt'

echo "Cleaning up the output..."
for f in $FILE_LIST;  
  do rm -Rf "${HOME}/${OUTPUT_DIR}/${f}" done
done
