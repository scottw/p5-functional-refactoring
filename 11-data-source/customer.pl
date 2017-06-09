#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin";
use HTML qw/to_html table_row_builder table_builder/;
use Flatfile qw/row_iterator/;

my $row_iter = row_iterator('customer.txt');

my $table_builder = table_builder(table_row_builder([qw/id name email/]), $row_iter);
to_html("Customers", $table_builder);
