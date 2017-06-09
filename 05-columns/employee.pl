#!/usr/bin/env perl
use strict;
use warnings;

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML 'to_html';

my $dbh = DBI->connect("dbi:SQLite:dbname=employee.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name FROM employee ORDER BY name
_SQL_

to_html(title => "Employees", sth => $sth, columns => [qw/id name/]);
