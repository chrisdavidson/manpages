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
my $broken_contrib_file = File::HomeDir::home() . "/manpages/output/broken_contrib.txt";

my $combined_base_file = File::HomeDir::home() . "/manpages/output/combined_base_refs.txt";
my $combined_contrib_file = File::HomeDir::home() . "/manpages/output/combined_contrib_refs.txt";

#main program loop
#combining the base file output with the initial refs
&combine_refs_base();
#combine the contrib file output with the initial refs
&combine_refs_contrib();

#We want to prepare the broken_refs file
#Objective - To make each reference to bad link its own line
#Input - ECT(1) tcpdump.1.gz cc_dctp.4.gz
#Output - ECT(1) tcpdump.1.gz
#         ECT(1) cc_dctp.4.gz
sub combine_refs_base() {
  open(my $fh, '<', $broken_refs_file) or die $!;
  open(my $ofh, '>>', $combined_base_file) or die $!;

  while (<$fh>) {
    my @split_line = split(" ", $_);
    my $entry = substr($split_line[0], 0, -3);
    my $wordstatus = findword($entry, $broken_base_file);
    if ($wordstatus ne "0") {
      print $ofh $split_line[0] . ":" . $wordstatus;
    }
  }
  close($ofh);
  close($fh);
}

sub combine_refs_contrib() {
  open(my $fh, '<', $broken_refs_file) or die $!;
  open(my $ofh, '>>', $combined_contrib_file) or die $!;

  while (<$fh>) {
    my @split_line = split(" ", $_);
    my $entry = substr($split_line[0], 0, -3);
    my $wordstatus = findword($entry, $broken_contrib_file);
    if ($wordstatus ne "0") {
      print $ofh $split_line[0] . ":" . $wordstatus;
    }
  }
  close($ofh);
  close($fh);
}

#this is a helper function to make it "cleaner" to find terms
#Pass arguments
#<word> - the word we are looking for
#<fhl> - the file to search for the results in
#
#Return
# 1 - Found it
# 0 - Did not Find It
sub findword() {
  my $word = shift;
  my $fhl = shift;
  open(my $fh, '<', $fhl) or die $!;

  while (<$fh>) {
    my @split_lines = split("/", $_);
    if ($split_lines[-1] =~ $word) {
      close($fh);
      return $_;
    }
  }
  close($fh);
  return(0);
}
