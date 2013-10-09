#!/bin/perl

use strict;
use warnings;

# This matches and extracts filenames from a chunk of a MS Visual
# Studio project (.vcproj) file.

while (<>) {
  if (/\s*RelativePath="(.*)">/) {
    print $1 . "\n";
 }
}
