#
# SPDX-License-Identifier: BSD-2-Clause
# 
#  Copyright 2024 Christopher Davidson
# 
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#!/bin/sh

ROOT_DIR="${HOME}/manpages"
ERROR_FILE="${ROOT_DIR}/output/broken_error_file.txt"
REF_FILE="${ROOT_DIR}/output/broken_refs.txt"
WHATIS_FILE="${ROOT_DIR}/output/whatis_results.txt"
ERROR_WHATIS_FILE="${ROOT_DIR}/output/error_whatis.txt"

#read the line from the $ERROR_FILE 
while read line; do
  RESULTS=$(echo $line | awk '{print substr($0, 1, length($0)-3)}')
  whatis $RESULTS 2>> /dev/null >> good_output.txt
done < $ERROR_FILE 
