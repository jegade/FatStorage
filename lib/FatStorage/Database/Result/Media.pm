package FatStorage::Database::Result::Media;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('media');

# Spalten
__PACKAGE__->add_columns( 

    media_id => {

        data_type       => "integer",
        size            => 11,
        is_auto_increment => 1,
        extra           => { unsigned => 1 },
   },

);

# Primary-Key
__PACKAGE__->set_primary_key('media_id');

# Beziehungen
__PACKAGE__->has_many('media_has_geos' , 'FatStorage::Database::Result::MediaHasGeo', 'media_id' );
__PACKAGE__->has_many('media_has_tags' , 'FatStorage::Database::Result::MediaHasTag', 'media_id' );
__PACKAGE__->has_many('media_has_files', 'FatStorage::Database::Result::MediaHasFile', 'media_id' );

1;
