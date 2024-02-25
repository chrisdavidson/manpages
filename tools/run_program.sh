#!/usr/local/bin/zsh

sh clean_up_files.sh
sh check_pages.sh
perl parse_broken_refs.pl
cp /home/chrisdavidson/manpages/output/broken_refs.txt /home/chrisdavidson/manpages/output/broken_refs.txt.bac
cat /home/chrisdavidson/manpages/output/broken_refs.txt.bac | tr -s '[:space:]' > /home/chrisdavidson/manpages/output/broken_refs.txt
perl combine_outputs.pl
sh mandoc_results.sh
perl check_whatis.pl
