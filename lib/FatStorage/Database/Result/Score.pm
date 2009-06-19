package FatStorage::Database::Result::Score;

use base qw/DBIx::Class/;

# Componenten für dieses Schema
__PACKAGE__->load_components(qw/PK::Auto Core/);

# Tablename innerhalb mysql
__PACKAGE__->table('score');

# Spalten
__PACKAGE__->add_columns(

    score_id => {

        data_type         => "integer",
        size              => 11,
        is_auto_increment => 1,
        extra             => { unsigned => 1 },
    },

    name => {

        data_type => "varchar",
        size      => 255,
    },

    priority => {
        data_type     => "integer",
        size          => 3,
        default_value => "1",
    },
);

# Primary-Key
__PACKAGE__->set_primary_key(qw/score_id/);

# Beziehungen
__PACKAGE__->has_many( 'files', 'FatStorage::Database::Result::File', 'score_id' );

1;
