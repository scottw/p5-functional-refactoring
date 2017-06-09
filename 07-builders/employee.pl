#!/usr/bin/env perl
use strict;
use warnings;

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder/;

my $dbh = DBI->connect("dbi:SQLite:dbname=employee.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name FROM employee ORDER BY name
_SQL_

my $row_builder = table_row_builder([qw/id name/]);
to_html(title => "Employees", sth => $sth, row_builder => $row_builder);
