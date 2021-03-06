#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use DBI;

my $dbh = DBI->connect("dbi:SQLite:dbname=customer.db", "", "")
  or die "Unable to connect: " . $DBI::errstr;

my $sth = $dbh->prepare(<<'_SQL_');
SELECT id, name FROM customer ORDER BY name
_SQL_

to_html(title => "Customers", sth => $sth);

sub to_html {
    my %args = @_;

    html_start(%args);

    $args{sth}->execute;

    say "<table>";
    while (my $row = $args{sth}->fetchrow_hashref) {
        say "  <tr>";
        say "    <td>" . $row->{id} . "</td>";
        say "    <td>" . $row->{name} . "</td>";
        say "  </tr>";
    }
    say "</table>";

    html_end();
}

sub html_start {
    my %args = @_;

    print <<"_START_";
<html>
<head>
<title>$args{title}</title>
</head>

<body>
_START_
}

sub html_end {
    print <<_END_;
</body>
</html>
_END_
}
