
# ううごかない
use strict;
use warnings;
use DBI;
use DBI::Executed;
use File::Spec;
use Data::Dumper;

my $dbfile = File::Spec->catfile( "t", "data", "test.db" );
my $dsn = "dbi:SQLite:$dbfile";
my $dbh = DBI->connect($dsn);

my $sth = $dbh->prepare("select * from colors where color = ? limit ?");
$sth->execute("red",3);

while(my $row = $sth->fetchrow_hashref){
    print Dumper $row;
}

print $dbh->executed_sql;


