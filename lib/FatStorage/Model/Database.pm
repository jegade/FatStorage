package FatStorage::Model::Database;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'FatStorage::Database',
    connect_info => [
        'dbi:mysql:fatstorage',
        'root',
        'nac',
        
    ],
);

=head1 NAME

FatStorage::Model::Database - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<FatStorage>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<FatStorage::Schema>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
