#!/usr/bin/env perl
use strict;
use warnings;

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder/;

my $dbh = DBI->connect("dbi:SQLite:dbname=customer.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name, email FROM customer ORDER BY name
_SQL_

my $row_builder = table_row_builder([qw/id name email/]);
to_html(title => "Customers", sth => $sth, row_builder => $row_builder);
