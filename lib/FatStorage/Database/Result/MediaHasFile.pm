package FatStorage::Database::Result::MediaHasFile;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('media_has_file');

# Spalten
__PACKAGE__->add_columns(

    media_id => {

        data_type         => "integer",
        size              => 11,
        extra             => { unsigned => 1 },
    },

    file_id => {

        data_type         => "integer",
        size              => 11,
        extra             => { unsigned => 1 },
    },


);

# Primary-Key
__PACKAGE__->set_primary_key(qw/media_id file_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'file',  'FatStorage::Database::Result::Tag', 'file_id' );
__PACKAGE__->belongs_to( 'media', 'FatStorage::Database::Result::Media', 'media_id' );


1;
