#!/usr/bin/env perl
use strict;
use warnings;

# first the system ones:
print "System colors:\n";
foreach my $color (0...15) {
    printf "\x1b[48;5;${color}m %03d ", $color;
    print "\x1b[0m\n" unless ($color + 1) % 8;
}
print "\n";

# now the color cube
print "Color cube, 6x6x6:\n";
foreach my $color (16..231)  {
    printf "\x1b[48;5;${color}m %03d ", $color;
    print "\x1b[0m\n" unless ($color - 15) % 6;
    print "\n" unless ($color - 15) % 36
}

# now the grayscale ramp
print "Grayscale ramp:\n";
foreach my $color (232..255) {
    printf "\x1b[48;5;${color}m %03d ", $color;
}
print "\x1b[0m\n";
