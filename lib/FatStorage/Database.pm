package FatStorage::Database;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_classes;

__PACKAGE__->mk_classdata('media_dir');

=head2 sqlt_deploy_hook

    Alle Datenbanken als UTF8 deployen

=cut 

sub sqlt_deploy_hook {

   my ($self, $sqlt_schema) = @_;

   for my $table ($sqlt_schema->get_tables) {
     $table->extra(
       mysql_charset => 'UTF8',
     );
   }
}


1;
