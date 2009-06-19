package FatStorage::Utils;

use strict;
use warnings;
use utf8;
use File::Slurp qw/slurp/;
use YAML qw/Load/;    # Lädt das Modul YAML und importiert die Funktion LoadFile
use FatStorage::Schema;
use Template();
use Template::Stash::XS();
use Data::Dumper;
use Log::Handler();
use File::Temp();
use Locale::Maketext::Simple( Export => "_loc", Path => '/www/FatStorage/lib/FatStorage/I18N', Decode => 1, );

use base 'Exporter';
use vars qw/@EXPORT_OK $base_path $config $schema $tt2 $log/;

@EXPORT_OK = qw/base_path config schema tt2/;

use File::Spec;
use Cwd qw/abs_path/;
my ( undef, $path ) = File::Spec->splitpath(__FILE__);

=head1 Beschreibung

Allgemeine Funktionen die auch ausserhalb des MVC-Webframeworks 
für Cron-Jobs/Jobserver oder Scripte gebraucht werden

=cut

=head2 base_path

    Den Basis-Pfad der Anwendung ermitteln

=cut

sub base_path {

    return $base_path if ($base_path);
    $base_path = abs_path("$path/../../");
    return $base_path;
}

=head2 config

    Die Konfiguration der Anwendung lesen

=cut

sub config {

    return $config if ($config);

    my $base_config_file  = "$path/../../FatStorage.yml";
    my $local_config_file = "$path/../../FatStorage_dev.yml";

    # Default - Produktions-Config
    if ( -e $base_config_file ) {

        # Normale Konfiguration lesen
        $config = _config_read($base_config_file);
    }

    # Prüfen ob eine Debug/Test-Konfiguration existiert
    if ( -e $local_config_file && !-e "/etc/live" ) {

        # Lokale Konfiguration lesen
        my $extra_config = _config_read($local_config_file);

        # Kombiniert die beiden Hash, die Extra-Konfiguration überschreibt Einträge der Basis-Konfiguratiokon
        $config = { %$config, %$extra_config };
    }

    return $config;
}

=head2 _config_read 

    Eine Config-Datei lesen, Macro-parsen und YAML in Hash konvertieren

=cut

sub _config_read {

    my ($config_file) = @_;

    # Datei einlesen
    my $yaml_config = slurp($config_file);

    # Macros ersetzen
    $yaml_config =~ s|__home__|$path/../../|gsixm;
    $yaml_config =~ s|__path_to\((.*?)\)__|$path/../../$1|gsixm;

    # YAML -> Hash
    return Load($yaml_config);
}

=head2 schema

    Datenbank-Handler, verbindet sich mit der Datenbank, aufgrund der in der config-datei vorgeben Parameter

    Rückgabe: DBIx::Class::Schema

=cut

sub schema {

    # Schema wurde schon verbunden, also globale Variable zurückgeben
    return $schema if ($schema);

    # Lese die Konfiguration, wenn diese nicht bereits gesetzt/ausgelesen ist
    $config ||= config();

    # Schema zur DB
    $schema = FatStorage::Schema->connect( @{ $config->{'Model::Database'}{connect_info} } );

    # Zusätzliche Parameter setzen
    $schema->media_dir( $config->{media_dir} );

    return $schema;
}

=head2 tt2

    Template-Handler, Config wird zentral ausgelesen

=cut

sub tt2 {

    return $tt2 if ($tt2);

    $config ||= config();

    $tt2 = Template->new( $config->{'View::TT'} );

    return $tt2;
}

=head2 dump

=cut

sub dump {

    my ($var) = @_;
    warn Dumper($var);
}

=head2 log 

    Beschreibung: Log-Handler
    Wird global initiert

=cut

sub log {

    # Objekt besteht bereits
    return $log if $log;

    # Config laden
    $config ||= config();

    $log = Log::Handler->new;

    $log->add(
        file => {
            filename => $config->{log_dir},
            mode     => 'append',
            maxlevel => 'debug',
            minlevel => 'warn',
            newline  => 1,
        }
    );

    return $log;

}

=head2 random

    Beschreibung : Zufallstringgenerator
    Parameter    : Länge des gewünschten Strings

=cut

sub random {

    my ( $self, $length ) = @_;

    $length ||= 12;

    # Nur zeichen verwenden die man nicht verwechseln kann I <> 1 oder l <> 1
    my @chars = (qw/a b c d e f g x y z 0 2 3 4 5 6 8 9/);

    my $random;

    foreach ( 1 .. $length ) {
        $random .= $chars[ rand @chars ];
    }

    return $random;
}

=head2 parsedatetime

	Try to parse any given date- and timestring, time_zone is optional

=cut

sub parsedatetime {

    my ( $self, $datestring, $timestring, $time_zone ) = @_;

    my ( $day, $month, $year ) = ( $datestring =~ /^\d{4}/ ) ? reverse split( /\D/, $datestring ) : split( /\D/, $datestring );
    my ( $hour, $minute, $second ) = split( /\D/, $timestring ) if ( defined $timestring );

    my $dt;
    my $now = DateTime->now( time_zone => ( $time_zone || 'local' ) );
    my $p = {};

    $p->{day}    = $day    || $now->day;
    $p->{month}  = $month  || $now->month;
    $p->{year}   = $year   || $now->year;
    $p->{hour}   = $hour   || $now->hour;
    $p->{minute} = $minute || $now->minute;
    $p->{second} = $second || $now->second;

    eval {

        # Try to build the DateTime-Object for the given datestring
        $dt = DateTime->new( %$p, time_zone => ( $time_zone || 'local' ) );
    };

    if ($@) {

        warn $@;
        return;
    }

    return $dt;
}

=head2

=cut


=head2 tmpfile

    Erzeugt eine temporäre Datei

=cut

sub tmpfile {

    my ( $class, $suffix ) = @_;
    my $fh = File::Temp->new( UNLINK => 0, SUFFIX => ( $suffix || '.tmp' ) );
    return $fh;
}

=head2 loc

    Lokalisierung mit Auswahl der Sprache

=cut

sub loc {

    my ( $self, $language, $string, @args ) = @_;
    _loc_lang($language);
    return _loc( $string, @args );
}


1;

