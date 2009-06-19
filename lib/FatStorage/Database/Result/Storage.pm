package FatStorage::Database::Result::Storage;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('storage');

# Spalten
__PACKAGE__->add_columns(

    storage_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    uri => {
        data_type => "varchar",
        size      => 128,
    },

    bytes_free => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    bytes_use => {
        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    bytes_total => {
        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },
);

# Primary-Key
__PACKAGE__->set_primary_key(qw/storage_id/);

# Beziehungen
__PACKAGE__->has_many( 'backups', 'FatStorage::Database::Result::Backup', 'storage_id' );

1;
