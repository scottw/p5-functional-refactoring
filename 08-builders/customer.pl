#!/usr/bin/env perl
use strict;
use warnings;

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder table_builder/;

my $dbh = DBI->connect("dbi:SQLite:dbname=customer.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name, email FROM customer ORDER BY name
_SQL_

to_html("Customers", table_builder(table_row_builder([qw/id name email/]), $sth));

