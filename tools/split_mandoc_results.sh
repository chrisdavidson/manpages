#!/usr/bin/zsh

MANDOC_STYLE="../output/mandoc_style_errors.txt"

echo "Deleting previously generated files..."
if [ -f ../output/mandoc_80characters_error.txt ]; then
  rm ../output/mandoc_80characters_error.txt;
elif [ -f ../output/mandoc_fn_error.txt ]; then
  rm ../output/mandoc_fn_error.txt;
elif [ -f ../output/mandoc_missingtitles_error.txt ]; then
  rm ../output/mandoc_missingtitles_error;
elif [ -f ../output/mandoc_newsentence_error.txt ]; then
  rm ../output/mandoc_newsentence_error.txt;
elif [ -f ../output/mandoc_whitespace_error.txt ]; then
  rm ../output/mandoc_whitespace_error.txt;
elif [ -f ../output/mandoc_tabs_error.txt ]; then
  rm ../output/mandoc_tabs_error.txt;
elif [ -f ../otuput/mandoc_escape_sequence_error.txt ]; then
  rm ../output/mandoc_escape_sequence_error.txt;
elif [ -f ../output/mandoc_paragraph_error.txt ]; then
  rm ../output/mandoc_paragraph_error.txt;
fi

echo "Splitting out style errors more than 80 characters..."
cat "${MANDOC_STYLE}" | grep "longer than 80" > ../output/mandoc_80characters_error.txt

echo "Finding issues with .Fn entries..."
cat "${MANDOC_STYLE}" | grep "Fn" > ../output/mandoc_fn_error.txt

echo "Finding missing manual titles.."
cat "${MANDOC_STYLE}" | grep "missing manual title" > ../output/mandoc_missingtitles_error.txt

echo "Finding new sentence style errors.."
cat "${MANDOC_STYLE}" | grep "new sentence" > ../output/mandoc_newsentence_error.txt

echo "Finding whitespace at end of lines.."
cat "${MANDOC_STYLE}" | grep "whitepsace at end" > ../output/mandoc_whitespace_error.txt

echo "Finding tab in filed text errors..."
cat "${MANDOC_STYLE}" | grep "tab in filled" > ../output/mandoc_tabs_error.txt

echo "Finding invalid escape sequence errors..."
cat "${MANDOC_STYLE}" | grep "invalid escape sequence" > ../output/mandoc_escape_sequence_error.txt

echo "Finding invalid paragraph macrco PP after SS.."
cat "${MANDOC_STYLE}" | grep "skipping paragraph macro" > ../output/mandoc_paragraph_error.txt
