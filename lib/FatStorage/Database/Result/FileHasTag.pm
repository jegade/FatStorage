package FatStorage::Database::Result::FileHasTag;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('file_has_tag');

# Spalten
__PACKAGE__->add_columns(

    file_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    tag_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/file_id tag_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'tag',  'FatStorage::Database::Result::Tag', 'tag_id' );
__PACKAGE__->belongs_to( 'file', 'FatStorage::Database::Result::File', 'file_id' );

1;
