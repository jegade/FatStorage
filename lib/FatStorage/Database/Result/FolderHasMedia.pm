package FatStorage::Database::Result::FolderHasMedia;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('folder_has_media');

# Spalten
__PACKAGE__->add_columns(

    folder_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    media_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/media_id folder_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'folder', 'FatStorage::Database::Result::Folder', 'folder_id' );
__PACKAGE__->belongs_to( 'media',  'FatStorage::Database::Result::Media', 'media_id' );

1;
