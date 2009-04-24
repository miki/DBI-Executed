package DBI::Executed;

use strict;
use warnings;
use base qw(DBI);

our $VERSION = '0.00001';
my $stderr;

sub import {
    my $original_connect = DBI->can('connect');
    no warnings 'redefine';
    *DBI::connect = sub {
        my $dbh = $original_connect->(@_);
        &_setup($dbh);
        return $dbh;
    };
    no strict 'refs';
    *DBI::db::executed_sql = \&executed_sql;
}

sub _setup {
    my $dbh = shift;
    close STDERR;
    open STDERR, '>', \$stderr or die $!;
    $dbh->{TraceLevel} = '3|SQL';
}

sub executed_sql {
    #print $stderr;
    $stderr =~ /Binding parameters: ([^(\<\-)|(\-\-\>)]*)/sg;
    my $sql = $1;
    if($sql !~ /./){
        $stderr =~ /parse_params statement ([^\<\-|\-\-\>]*)/sg;
        $sql = $1;
    }
    $sql =~ s/\n//g;
    $sql =~ s/\t//g;
    return $sql;
}

1;
__END__

=head1 NAME

DBI::Executed - extracts executed sql query

=head1 SYNOPSIS

  use DBI;
  use DBI::Executed;

  my $dbh = DBI->connect($dsn, $user, $pass);
  $dbh->prepare("select * from table where column = ?");
  my $sth = $dbh->execute("aaa");
  ....do something
  my $sql_string = $dbh->executed_sql;

  print $sql_string;
  # select * from where column = aaa

=head1 DESCRIPTION

DBI::Executed extracts executed sql query that was binded with variables.

It works only at MySQL.


=head1 METHODS

=head2 executed_sql

=head1 AUTHOR

takeshi miki E<lt>miki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
