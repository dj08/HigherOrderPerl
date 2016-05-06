#!/usr/bin/perl

=head1 DESCRIPTION

Simple template for running scripts as a module... makes it easier to debug

=cut

package Local::Modulino;

__PACKAGE__->run( @ARGV ) unless caller();

sub run { print "I'm in a script, Caller is ".caller()." \n" }

__END__
