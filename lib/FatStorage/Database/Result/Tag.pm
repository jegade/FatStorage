package FatStorage::Database::Result::Tag;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('tag');

# Spalten
__PACKAGE__->add_columns(

    tag_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    name => {

        data_type => "varchar",
        size      => 255,
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/tag_id/);

# Beziehungen

__PACKAGE__->has_many( 'media_has_tags', 'FatStorage::Database::Result::MediaHasTag', 'tag_id' );
__PACKAGE__->has_many( 'file_has_tags', 'FatStorage::Database::Result::FileHasTag', 'tag_id' );


1;
