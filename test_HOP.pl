#!/usr/bin/env perl

use v5.014;
use HigherOrderPerl qw( dir_walk );

my $needed=1;
say "Hi!";

# Print all contents in a dir hierarchy
Local::HigherOrderPerl::dir_walk( ".", sub { say $_[0] } );
# dir_walk( ".", sub { say $_[0] } );

# Print size of a file, alongwith it's name
Local::HigherOrderPerl::dir_walk
    ( '.',
      sub {
          printf "%6d %s\n", -s $_[0], $_[0]
      } );
