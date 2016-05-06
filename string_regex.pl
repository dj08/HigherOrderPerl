#!/usr/bin/env perl

use v5.14;

my $string = <<'HERE';
This is line one
This is a cat
This is a dog
 This is a lizard
This is a bird
That is a ostrich
HERE

my @matches = $string =~ m/
	^This\ is\ a\ (\S+) \s+
	^This\ is\ a\ (\S+)
	/xmg;
	
say "Matches are @matches";

my $dot_dot_string = "START
Flintstones END
START Wilma END";

open my $fh, '<', "string_regex.txt";
while ( <$fh> ) {
    say "Caught $_" if /START/ .. /END/;
}
