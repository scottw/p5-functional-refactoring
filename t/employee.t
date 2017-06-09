#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

my $dir = $ENV{TEST_DIR} // '03-modify';

open my $pipe, "-|", "perl", "$dir/employee.pl"
  or die "Unable to open pipe: $!\n";

local $/;
my $output = <$pipe>;
close $pipe;

is($output, <DATA>, "output matches");

exit;

__DATA__
<html>
<head>
<title>Employees</title>
</head>

<body>
<table>
  <tr>
    <td>2</td>
    <td>Scott C</td>
  </tr>
  <tr>
    <td>3</td>
    <td>Scott D</td>
  </tr>
  <tr>
    <td>1</td>
    <td>Scott W</td>
  </tr>
</table>
</body>
</html>
