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
#!/usr/bin/perl -w
use strict;
use warnings;
use File::HomeDir;

my $error_file = File::HomeDir::home() . "/manpages/output/broken_error_file.txt";
my $whatis_file = File::HomeDir::home() . "/manpages/output/whatis_results.txt";
my $error_whatis_file = File::HomeDir::home() . "/manpages/output/error_whatis.txt";

&iterate_error_file();
&strip_emptylines();
&dedup_whatis_results();

sub iterate_error_file() {
  open(my $fh, '<', $error_file) or die $!;

  while (<$fh>) {
    my $manual_page = substr($_, 0, -3);
    print "fetching details about: " . $manual_page . "\n";
    my $results = `man -f $manual_page`;
    capture_results($manual_page, $results);
  }
  close($fh);
}

sub capture_results() {
  my $manual_page = shift;
  my $entry = shift;
  
  open(my $fh, '>>', $whatis_file) or die $!;
  print $fh $manual_page . ": " . $entry;
  close($fh);
}

sub strip_emptylines() {
  open(my $fh, '<', $whatis_file) or die $!;
  
  while (<$fh>) {
    next if m/^\s+$/;
  }
  close($fh);
}

sub dedup_whatis_results() {
  my %seen = ();

  local @ARGV = ($whatis_file);
  local $^I = '.bac';

  while (<>) {
    $seen{$_}++;
    next if $seen{$_} > 1;
    print;
  }
}
