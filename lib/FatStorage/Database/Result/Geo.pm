package FatStorage::Database::Result::Geo;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('geo');

# Spalten
__PACKAGE__->add_columns(

    geo_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    name => {

        data_type => "varchar",
        size      => 255,
    },

    lat => {
        data_type     => "DECIMAL",
        size          => [ 11, 8 ],
        default_value => "000.0000000000",
    },

    lon => {
        data_type     => "DECIMAL",
        size          => [ 11, 8 ],
        default_value => "000.0000000000",
    },

);

# Primary-Key
__PACKAGE__->set_primary_key(qw/geo_id/);

# Beziehungen

__PACKAGE__->has_many( 'media_has_geos', 'FatStorage::Database::Result::MediaHasGeo', 'geo_id' );
__PACKAGE__->has_many( 'file_has_geos',  'FatStorage::Database::Result::FileHasGeo', 'geo_id' );

1;
