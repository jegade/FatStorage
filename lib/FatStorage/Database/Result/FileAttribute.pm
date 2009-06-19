package FatStorage::Database::Result::FileAttribute;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('file');

# Spalten
__PACKAGE__->add_columns(

    file_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },


    key => {

        data_type => "varchar",
        size      => 255,
    },

    value => {
        data_type => "varchar",
        size      => 65000,
    },
);

# Primary-Key
__PACKAGE__->set_primary_key(qw/file_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'file', 'FatStorage::Database::Result::File', 'file_id' );

1;
