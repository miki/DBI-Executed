use strict;
use warnings;

use DBI;
use DBI::Executed;

my $dsn  = 'dbi:mysql:mysql:mwk102';
my $user = 'tech';
my $pass = "";

my $dbh = DBI->connect( $dsn, $user, $pass );

for ( 1 .. 10 ) {
    my $sth = $dbh->prepare("select * from user limit ?");
    $sth->execute($_);
    my $row = $sth->fetchrow_hashref;

    print $dbh->executed_sql, "\n";
}
