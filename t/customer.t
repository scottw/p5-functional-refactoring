#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

my $dir = $ENV{TEST_DIR} // '01-employee';

open my $pipe, "-|", "perl", "$dir/customer.pl"
  or die "Unable to open pipe: $!\n";

local $/;
my $output = <$pipe>;
close $pipe;

is($output, <DATA>, "output matches");

exit;

__DATA__
<html>
<head>
<title>Customers</title>
</head>

<body>
<table>
  <tr>
    <td>3</td>
    <td>Arthur Fonzarelli</td>
    <td>the@fonz.com</td>
  </tr>
  <tr>
    <td>2</td>
    <td>Potsie Weber</td>
    <td>potsie@weber.org</td>
  </tr>
  <tr>
    <td>4</td>
    <td>Ralph Malph</td>
    <td>ralph@malph.me</td>
  </tr>
  <tr>
    <td>1</td>
    <td>Richie Cunningham</td>
    <td>richie@cunningham.org</td>
  </tr>
</table>
</body>
</html>
