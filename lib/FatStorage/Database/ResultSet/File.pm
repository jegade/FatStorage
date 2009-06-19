package FatStorage::Database::ResultSet::File;

use utf8;
use strict;
use warnings;
use base qw(DBIx::Class::ResultSet);

use Digest::MD5 qw/md5_hex/;
use Carp;
use File::Path;
use File::Spec;
use File::Basename;
use File::Copy;
use File::MMagic;

=head2 fileimport

    Import der Mediendatei 

=cut 

sub fileimport {

    my ( $self, $media, $attr ) = @_;

    my $sourcefile = $attr->{sourcefile};         # Vollständiger Dateiname mit Pfad für den Import oder FH
    my $kind       = $attr->{kind} || 'file';     # Art der Datei
    my $type       = $attr->{type} || 'media';    # Type media/file/???
    my $mode       = $attr->{mode} || 'async';    # Resize-Vorgang bei Grafiken direkt oder über den Jobserver
    my $replace    = $attr->{replace};            # Vorhandene Datei ersetzen, dazu muss replace auf die media_id der zu ersetzenden Datei gesetzt werden
    my $restrict   = $attr->{restrict};           # Import-Restriction auf bestimmte Dateitypen
    my $filename   = lc($attr->{filename});       # Name der Datei

    $filename =~ s/[^\w\ \._-]//ig;

    # Fehlerbehandlung
    croak('Es wurde keine Datei uebergeben')            unless $sourcefile;
    croak("Die Datei $sourcefile wurde nicht gefunden") unless -e $sourcefile;
    croak("Bitte Dateiname angeben")                    unless $filename;

    # Basisverzeichnis der Bilder
    my $basedir = $self->result_source->schema->media_dir;

    my $mimemagic = new File::MMagic;

    # MIME-Type
    my $mimetype = $mimemagic->checktype_filename($sourcefile) || 'application/octet-binary';
    my $filetype = $filename;

    $filetype =~ s/^.*\.(.+?)$/$1/g;

    # jpeg => jpg
    $filetype =~ s/jpeg/jpg/g;

    # Dateigrösse
    my $filesize = -s $sourcefile;

    # Prüfen ob Mime-Type-Restriction vorhanden
    if ( $restrict && !grep { $_ eq $mimetype } @$restrict ) {

        # Quelldatei löschen, wenn nicht aus tmp
        unlink $sourcefile unless $sourcefile =~ m/tmp/;

        # Weitre Verarbeitung abbrechen
        return;
    }

    # Auf der MD5-Summe basiertes Unterverzeichnis erzeugen
    my $md5 = md5_hex($sourcefile);

    # Unterverzeichnis, zufällig
    my $subdir = sprintf( "%02d", rand(100) );

    # Zielverzeichnis
    my $targetdir = File::Spec->catdir( $basedir, $subdir );

    # Zieldatei, original
    my $targetfile = File::Spec->catfile( $basedir, $subdir, $md5 . "." . $filetype );

    # Zielverzeichnis erzeugen
    my $mkpath = mkpath( $targetdir, undef, 0750 );
	
    # Datei verschieben/kopieren
    if($sourcefile =~ m/tmp/) {

        # Upload via CGI aus TMP, verschieben
		move( $sourcefile, $targetfile );
	
    } else {
        
        # Manueller Import, kopieren
        copy( $sourcefile, $targetfile );		
	}

    my $file = $self->create(
        {
            filename => ( $filename || $md5 . "." . $filetype ),
            filesize => $filesize,
            filetype => $filetype,
            md5      => $md5,
            subdir   => $subdir,
            mimetype => $mimetype,
            kind     => $kind,
            media_id => $media->media_id,
        }
    );

    return $file;
}
1;
