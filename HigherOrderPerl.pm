#!/usr/bin/env perl

=head1 DESCRIPTION

Just a place to exercise concepts from Higher Order Perl

The way this works is: call the script with the functions and the
arguments you want to execute. That's it!

=cut

use 5.014;
no strict 'refs'; # just for now...

package Local::HigherOrderPerl;

__PACKAGE__->run( @ARGV ) unless caller();

sub run {
  print "I'm in a script, Caller is ".caller()." \n";
  print $ARGV[0]->( @ARGV [1..$#ARGV] ); # Function reference... abstraction!
}

=head1 CHAPTER 01

=cut

##################################################

sub binary {
  identify( @_ );
  my $num = shift;
  
  # Base case
  return $num if $num == 1 || $num == 0;
  
  # Otherwise, $num=2k+b, then binary of $k
  my ( $num, $b ) = ( int $num/2, $num%2 );
  
  return binary( $num )."$b";
  # return $num_binary;
}

##################################################

sub factorial {
  identify( @_ );
  my $num = shift; # Assume integers

  # Base case
  return 1 if $num == 0 || $num == 1;

  # Otherwise, fact(n) = fact(n-1).n
  return factorial( $num-1 ) * $num
}

##################################################

sub hanoi {
  identify( @_ );
  # Function assumes three pegs, with n graduated disks placed on top
  # of each other. It will now give instructions to move all as per TOH.

  my ( $n, $start_peg, $end_peg, $extra_peg ) = @_;

  # Base case: If tower has only 1 disk, move it.
  if ( $n == 1 ) {
    say "Move disk $n from $start_peg to $end_peg";
    return; # This is like implementing the else condition...
  } 
  
  # Otherwise, move all but the BIG disk from start peg to extra peg,
  # using end peg as a workspace
  hanoi( $n-1, $start_peg, $extra_peg, $end_peg );
  
  # then move BIG disk from start peg to end peg
  say "Move disk $n from $start_peg to $end_peg.";
  
  # Move all other disks back from the extra peg to end peg
  hanoi( $n-1, $extra_peg, $end_peg, $start_peg );
}

##################################################

sub total_size {
  # Compute total size of a directory using recursion
  my $stuff = pop;
  my $size = -s $stuff;
  my $dir;

  return ( $size ) if ( ! -d $stuff ); # Return size as is if it's a file

  # else... dig in $stuff
  # warn if dir error
  unless ( opendir ( $dir, $stuff )) {
    warn "Couldn't open dir $stuff, skipping!\n";
    return $size;
  }

  # now start digging
  my $content;
  while ( $content = readdir $dir ) {
    # return sum of total_size for each element digged
    next if $content eq '.' || $content eq '..';
    $size += total_size( "$stuff/$content" );
  }
  
  closedir $dir;
  return $size;
}

##################################################

sub dir_walk {
  # identify( @_ );
  # Function to walk a directory structure recrusively and apply $code
  my ( $stuff, $code ) = @_;
  my $dir;

  $code->( $stuff ); # Apply code to $stuff

  if ( -d $stuff ) { # Dig in if it's a dir
    unless ( opendir ( $dir, $stuff )) {
      warn "Couldn't open dir $stuff, skipping!\n";
      return;
    }
    
    # now start digging
    my $content;
    # foreach $content ( readdir $dir ) {
    while ( $content = readdir $dir ) {
      # return sum of total_size for each element digged
      next if $content eq '.' || $content eq '..';
      dir_walk( "$stuff/$content", $code );
    }
    closedir $dir;
  }
  
}

##################################################
sub identify {
  # Identify the parent calling this guy
  print "Executing function ".( caller(1) )[3]." with args: @_ !\n";
}
__END__
