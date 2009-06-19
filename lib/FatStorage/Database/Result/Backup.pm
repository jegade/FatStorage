package FatStorage::Database::Result::Backup;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('backup');

# Spalten
__PACKAGE__->add_columns(

    backup_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    file_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    storage_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    md5 => {
        data_type => 'varchar',
        size      => '40',
    },

    backup_date => {
        data_type     => "datetime",
        timezone      => "UTC",
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/backup_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'file',    'FatStorage::Database::Result::File', 'file_id' );
__PACKAGE__->belongs_to( 'storage', 'FatStorage::Database::Result::Storage', 'storage_id' );


1;
