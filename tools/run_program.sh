#!/usr/local/bin/zsh

sh clean_up_files.sh
sh check_pages.sh
perl parse_broken_refs.pl
perl combine_outputs.pl
sh mandoc_results.sh
perl check_whatis.pl
