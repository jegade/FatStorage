#!/usr/bin/perl -w
use strict;
use warnings;
use Fuse;
use POSIX;

my $mountpoint = shift;

sub getattr {
    my $file = shift;
    print "getattr $file\n";
    return -ENOENT();
}

sub getdir {
    my $dir = shift;
    print "get dir $dir\n";
    return ( '.', 0 );
}

Fuse::main(
    mountpoint => $mountpoint,
    getdir     => \&getdir,
    getattr    => \&getattr
);


