#!/usr/bin/perl -w
use strict; use warnings;
use Fuse;
my $mountpoint =  shift;

Fuse::main( mountpoint => $mountpoint );
