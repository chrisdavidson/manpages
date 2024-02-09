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
#!/usr/bin/perl
use strict;
use warnings;
use File::HomeDir;

#Global Variable space
my $broken_refs_file = File::HomeDir::home() . "/manpages/output/broken_refs.txt";
my $broken_base_file = File::HomeDir::home() . "/manpages/output/broken_base.txt";

#main program loop
&realign_broken_refs();

#We want to prepare the broken_refs file
#Objective - To make each reference to bad link its own line
#Input - ECT(1) tcpdump.1.gz cc_dctp.4.gz
#Output - ECT(1) tcpdump.1.gz
#         ECT(1) cc_dctp.4.gz
sub realign_broken_refs() {
  open(my $fh, '<', $broken_refs_file) or die $!;

  while (<$fh>) {
    my @split_line = split(" ", $_);
    foreach my $entry (@split_line) {
      print $entry . " length: " . length($entry) . "\n";
    }
  }
}
