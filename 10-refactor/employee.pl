#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder table_builder/;
use SQLite qw/db_connect row_iterator/;

my $row_iter = row_iterator(db_connect('employee.db')->prepare(<<'_SQL_'));
SELECT id, name FROM employee ORDER BY name
_SQL_

my $table_builder = table_builder(table_row_builder([qw/id name/]), $row_iter);
to_html("Employees", $table_builder);
