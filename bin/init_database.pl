#!/usr/bin/perl 

use strict;
use warnings;
use utf8;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use FatStorage::Utils;

my $schema = FatStorage::Utils->schema;

$schema->resultset('Media')->delete_all;
$schema->resultset('Tag')->delete_all;
$schema->resultset('Score')->delete_all;

$schema->resultset('Score')->create( { name => "Super", priority => 1 } ) ;
