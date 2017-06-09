#!/usr/bin/env perl
use strict;
use warnings;

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder table_builder/;

my $dbh = DBI->connect("dbi:SQLite:dbname=employee.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name FROM employee ORDER BY name
_SQL_

$sth->execute();

my $row_iter = sub {
    $sth->fetchrow_hashref;
};

my $table_builder = table_builder(table_row_builder([qw/id name/]), $row_iter);
to_html("Employees", $table_builder);
