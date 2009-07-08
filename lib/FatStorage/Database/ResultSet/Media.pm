package FatStorage::Database::ResultSet::Media;

use utf8;
use strict;
use warnings;
use base qw(DBIx::Class::ResultSet);

=head2 mediaimport

    Import der Mediendatei 

=cut 

sub mediaimport {

    my ( $self, $files ) = @_;

    # Neues Media initieren
    my $media = $self->create( {} );

    # 
    foreach my $file (@$files) {
        $self->result_source->schema->resultset('File')->fileimport( $media , { sourcefile => $file, filename => "xxx.jpg" } );
    }

    return $files;
}
1;
