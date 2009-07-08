#!/usr/bin/perl 

use strict;
use warnings;
use utf8;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use FatStorage::Utils;

my @files = @ARGV;

die "Bitte die Datei angeben: import_media.pl /data/path/to/file.ext" unless @files > 0;


my $config = FatStorage::Utils->config;

use Data::Dumper;


my $schema = FatStorage::Utils->schema;

# Alle Dateien als Set importieren
my $media = $schema->resultset('Media')->mediaimport( \@files );

