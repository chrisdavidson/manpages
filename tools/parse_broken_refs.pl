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

my $base_file = "/home/chrisdavidson/manpages/output/broken_base.txt";
my $ref_file = "/home/chrisdavidson/manpages/input/broken_refs.txt";
my $contrib_file = "/home/chrisdavidson/manpages/output/broken_contrib.txt";
my $error_file = "/home/chrisdavidson/manpages/output/broken_error_file.txt";
my $temp_file = "/home/chrisdavidson/manpages/output/temporarytxt";
my @output_files = qw ($base_file $contrib_file $error_file $temp_file);

my $directory = "/usr/src";
my %manpages;

&clear_old_files();

find({
    wanted => \&process_files 
  }, $directory);

&process_refs_file();

sub process_refs_file() {
  open(my $fh, '<', $ref_file) or die $!;

  while (<fh>) {
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
  close(fh);
}

sub create_contrib_file() {
  my $key = shift;
  my $value = shift;
  open(my $cfh, '>>', $contrib_file) or die $!;
  print cfh $key . " " . $value . "\n";
  close(cfh);
}

sub create_base_file() {
  my $key = shift;
  my $value = shift;
  open(my $bfh, '>>', $base_file) or die $!;
  print bfh $key . " " . $value . "\n";
}

sub create_error_file() {
  my $entry = shift;
  open(my $efh, '>>', $error_file) or die $!;
  print efh $entry . "\n";
  close(efh);
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

sub clear_old_files() {
  for my $f (@output_files) {
    system "rm -rf $f";
  }
}

