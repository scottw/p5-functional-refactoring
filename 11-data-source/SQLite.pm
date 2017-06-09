package SQLite;

use DBI;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(db_connect row_iterator);

sub db_connect {
    my $db_name = shift;

    DBI->connect("dbi:SQLite:dbname=$db_name", "", "")
      or die "Unable to connect: " . $DBI::errstr;
}

sub row_iterator {
    my $sth = shift;

    $sth->execute;

    return sub {
        $sth->fetchrow_hashref;
    };
}

1;
