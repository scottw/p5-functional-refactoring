#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use DBI;

use FindBin;
use lib "$FindBin::Bin";
use HTML 'to_html';

my $dbh = DBI->connect("dbi:SQLite:dbname=customer.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name, email FROM customer ORDER BY name
_SQL_

to_html(
    title       => "Customers",
    sth         => $sth,
    row_builder => sub {
        my $row = shift;

        say "  <tr>";
        for my $col (qw/id name email/) {
            say "    <td>" . $row->{$col} . "</td>";
        }
        say "  </tr>";
    }
);
