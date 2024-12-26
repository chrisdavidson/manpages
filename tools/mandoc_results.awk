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
#!/usr/bin/awk -f

output_80chars = "../output/mandoc/style_80chars.txt"
output_fn = "../output/mandoc/style_fn.txt"
output_tn = "../output/mandoc/style_tn.txt"
output_ud = "../output/mandoc/style_ud.txt"
output_sp = "../output/mandoc/style_sp.txt"
output_cross = "../output/mandoc/warning_cross_reference.txt"
output_section_order = "../output/mandoc/warning_section_order.txt"
output_macro_fx = "../output/mandoc/style_macro_fx.txt"
output_miss_arg = "../output/mandoc/style_miss_args.txt"
output_new_sentence = "../output/mandoc/style_new_sentence.txt"
output_blank_line = "../output/mandoc/warning_blank_line.txt"
output_no_manual = "../output/mandoc/style_no_manual.txt"
output_trailing_del = "../output/mandoc/style_trailing_del.txt"

{
  if ($0 ~ /STYLE/) {
    if ($0 ~ /longer than 80/) { print > output_80chars; next; }
    else if ($0 ~ /Fn/) { print > output_fn; next; }
    else if ($0 ~ /Tn/) { print > output_tn; next; }
    else if ($0 ~ /Fx/) { print > output_macro_fx; next; }
    else if ($0 ~ /Ud/) { print > output_ud; next; }
    else if ($0 ~ /blank line in fill mode/) {print > output_sp, next; }
    else if ($0 ~ /referenced manual not found/) {print > output_no_manual; next; }
    else if ($0 ~ /trailing delimiter/) {print > output_trailing_del; next; }
  } else if ($0 ~ /WARNING/) {
    if ($0 ~ /cross reference/) { print > output_cross; next; }
    else if ($0 ~ /sections out of/) { print > output_section_order; next; }
    else if ($0 ~ /new sentence/) { print > output_new_sentence; next; }
    else if ($0 ~ /blank line/) { print > output_blank_line; next; }
  }
}
