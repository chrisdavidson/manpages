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
#

#helper function to return the <manual page>(<section #>)
function mp(page, sec) {
    return sprintf("%s(%i)", page, sec)
}

function addref(fname, page, section) {
    # weird references prefixed by \&
    if (substr(page, 1, 2) == "\\&") page = substr(page, 3)
   
    #check to see if the page variable is set
    if (!page) return
    k = mp(page, sec)
   
    if (k in existing) return
    fk = fn ":" k
    
    if (fk in seen_in_file) return
   
    #adding to the master list for consideration
    global_references[k] = global_references[k] " " fn
    ++seen_in_file[fk]
}

BEGIN {
    #lets check the manual pages and iterate through each one
    #we want to capture section, page details for processing
    while ("find /usr/share/man -type f" | getline) {
        sub(/\.gz$/, "", $0)
        if (/\.[1-9]$/) {
            sub(".*/", "", $0)
            sec=substr($0, length, 1)
            page=substr($0, 1, length-2)
            existing[mp(page, sec)] = 1
        }
    }
    #caputring roff font information 
    roff["\\fB"] #bold text
    roff["\\fI"] #italic text
    roff["\\fR"] #Romain font
}

#main iteration loop, cycled through until the whole list of manual
#pages are complete and accounted for.
{
    fn = $1
    sub(/:.*/, "", fn)
    sub(".*/", "", fn)

    # .Xr page section
    s = $0
    while (match(s, /\.Xr  *[^ ][^ ]*  *[1-9]/)) {
        rest = substr(s, RSTART+4)
        split(rest, bits, /  */)
        page = bits[1]
        sec = substr(bits[2], 1, 1)
        addref(fn, page, sec)
        s = substr(rest, RLENGTH)
    }

    # straight up program(section)
    s = $0
    while (match(s, /[a-zA-Z][-a-zA-Z0-9.]*[a-zA-Z0-9]\([1-9]\)/) ) {
        probe = substr(s, RSTART - 1, 3)
        if (probe in roff) {
            RSTART += 2
            RLENGTH -= 2
        }
        k = substr(s, RSTART, RLENGTH)
        split(k, bits, /[()]/)
        page = bits[1]
        sec = bits[2]
        addref(fn, page, sec)
        s = substr(s,  RSTART + RLENGTH)
    }

    #looking for entries that are using \fB and \fR from groff to define
    #the layout of the manual page itself
    s = $0
    while (match (s, /\\f[IB][a-zA-Z][a-zA-Z.]*\\fR\([1-9]\)/) ) {
        page = substr(s, RSTART+3, RLENGTH-(3+6))
        sec = substr(s, RSTART+RLENGTH-2, 1)
        addref(fn, page, sec)
        s = substr(s,  RSTART + RLENGTH)
    }
}

END {
    #bringing it all together to have the link and all the files that reference this manual page
    for (k in global_references) print k, global_references[k]
}
