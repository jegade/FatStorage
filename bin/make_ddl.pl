#!/usr/bin/perl 

use utf8;

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use FatStorage::Utils;

# Schema
my $schema = FatStorage::Utils->schema;

# neue version
my $old = 1;

# alte version ( optional )
my $old = undef;

# Schema erzeugen
$schema->create_ddl_dir( ['MySQL' ], $new , "../sql/", $old );
