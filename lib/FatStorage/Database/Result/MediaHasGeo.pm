package FatStorage::Database::Result::MediaHasGeo;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('media_has_geo');

# Spalten
__PACKAGE__->add_columns(

    media_id => {

        data_type         => "integer",
        size              => 11,
        extra             => { unsigned => 1 },
    },

    geo_id => {

        data_type         => "integer",
        size              => 11,
        extra             => { unsigned => 1 },
    },


);

# Primary-Key
__PACKAGE__->set_primary_key(qw/media_id geo_id/);

# Beziehungen
__PACKAGE__->belongs_to( 'geo',   'FatStorage::Database::Result::Geo',  'geo_id' );
__PACKAGE__->belongs_to( 'media', 'FatStorage::Database::Result::Media', 'media_id' );


1;
