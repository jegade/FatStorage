package FatStorage::Database::Result::File;

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

    media_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },


    score_id => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    filesize => {

        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    filename => {

        data_type => "varchar",
        size      => 255,
    },

    mimetype => {
        data_type => "varchar",
        size      => 64,
    },

    revision => {
        data_type => "integer",
        size      => 11,
        extra     => { unsigned => 1 },
    },

    md5 => {
        data_type => 'varchar',
        size      => '40',
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/file_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'media', 'FatStorage::Database::Result::Media', 'media_id' );
__PACKAGE__->belongs_to( 'score', 'FatStorage::Database::Result::Score', 'score_id' );

__PACKAGE__->has_many( 'file_has_geos', 'FatStorage::Database::Result::FileHasGeo', 'file_id' );
__PACKAGE__->has_many( 'file_has_tags', 'FatStorage::Database::Result::FileHasTag', 'file_id', );

__PACKAGE__->has_many( 'backups',    'FatStorage::Database::Result::Backup',        'file_id' );
__PACKAGE__->has_many( 'attributes', 'FatStorage::Database::Result::FileAttribute', 'file_id' );

1;
