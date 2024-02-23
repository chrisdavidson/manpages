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
use File::Find;
use File::Copy;
use File::HomeDir;

#main set of files, these are first pass creation
my $base_file = File::HomeDir::home() . "/manpages/output/broken_base.txt";
my $ref_file = File::HomeDir::home() . "/manpages/input/broken_refs.txt";
my $contrib_file = File::HomeDir::home() . "/manpages/output/broken_contrib.txt";
my $error_file = File::HomeDir::home() . "/manpages/output/broken_error_file.txt";

my $directory = File::HomeDir::home() . "/src/manuals";
my %manpages;

#we are going to find all the files we care about for this processing
find({
    wanted => \&process_files 
  }, $directory);

&process_refs_file();
&dedup_contrib_file();
&dedup_base_file();

#This is the main function that does the heavy lifting of parsing files and splitting up
sub process_refs_file() {
  open(my $fh, '<', $ref_file) or die $!;

  while (<$fh>) {
    my @split_line = split(/ /, $_);

    foreach my $item (@split_line) {
      if ($item =~ /gz$/) {
        $item =~ s/\s+$//g;
        my $manual_page = substr($item, 0, -3);
        my ($key, $value) = search_processed_files($manual_page);
        if (length($key) == 0) {
          create_error_file($manual_page);
        } else {
          if ($value =~ '/contrib/') {
            create_contrib_file($key, $value);
          } else {
            create_base_file($key, $value);
          }
        }
      }
    }
  }
  close($fh);
}

#this is a helper function to create entries in the "contrib" area
sub create_contrib_file() {
  my $key = shift;
  my $value = shift;

  open(my $cfh, '>>', $contrib_file) or die $!;
  print $cfh $key . " " . $value . "\n";

  close($cfh);
}

#There is a good chance we have duplicate rows in the contrib file
#lets get rid of them to reduce the noise in the files
sub dedup_contrib_file() {
  my %seen = ();

  local @ARGV = ($contrib_file);
  local $^I = '.bac';
  
  while(<>) {
    $seen{$_}++;
    next if $seen{$_} > 1;
    print;
  }
}

#this is a helper function to create entries in the "base" area
sub create_base_file() {
  my $key = shift;
  my $value = shift;
  
  open(my $bfh, '>>', $base_file) or die $!;
  print $bfh $key . " " . $value . "\n";
}

sub dedup_base_file() {
  my %seen = ();

  local @ARGV = ($base_file);
  local $^I = '.bac';

  while(<>) {
    $seen{$_}++;
    next if $seen{$_} > 1;
    print;
  }
}

#this is a helper function to create error entries from processing
sub create_error_file() {
  my $entry = shift;
  open(my $efh, '>>', $error_file) or die $!;
  print $efh $entry . "\n";
  close($efh);
}

sub search_processed_files() {
  my $item = shift;
  for my ($key, $value) (%manpages) {
    if ($key eq $item) {
      return $key, $value;
    } 
  }
}

sub process_files() {
  if ( -f $_ && /\.[0-9]$/) {
    $manpages{$_} = $File::Find::name;
  }
}
