package FatStorage::Database::Result::Folder;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('folder');

# Spalten
__PACKAGE__->add_columns(

    folder_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    foldername => {

        data_type => "varchar",
        size      => 255,
    },
);

# Primary-Key
__PACKAGE__->set_primary_key(qw/folder_id/);

# Beziehungen
__PACKAGE__->has_many( 'folder_has_medias', 'FatStorage::Database::Result::FolderHasMedia', 'folder_id' );
 

1;
