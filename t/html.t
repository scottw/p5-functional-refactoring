#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Test::More tests => 6;

## Because we print to STDOUT in HTML.pm, we have to use this wonky
## dup and open-to-scalar-ref to catch the output. Again, this is not
## about templating, this is about refactoring. Well-refactored code
## has a small, easily testable surface area and does not cross its
## domain boundary.

my $dir;
BEGIN { $dir = $ENV{TEST_DIR} // '09-iterator' }
use lib $dir;
use_ok('HTML');

open my $oldout, ">&STDOUT" or die "Can't dup STDOUT: $!";
close STDOUT;
my $test;
open STDOUT, ">", \$test or die "Can't open STDOUT: $!";

my $title = "Testing";
HTML::html_start($title);
is($test, <<"_HTML_", "begin html");
<html>
<head>
<title>$title</title>
</head>

<body>
_HTML_

undef $test;
open STDOUT, ">", \$test or die "Can't open STDOUT: $!";

HTML::html_end();
is($test, <<"_HTML_", "end html");
</body>
</html>
_HTML_

undef $test;
open STDOUT, ">", \$test or die "Can't open STDOUT: $!";

my @rows = ({ foo => 'bar' });
my $tb = HTML::table_builder(sub { my $r = shift; say $r->{foo} }, sub { shift @rows });
$tb->();
is($test, <<"_HTML_", "table builder");
<table>
bar
</table>
_HTML_

undef $test;
open STDOUT, ">", \$test or die "Can't open STDOUT: $!";

my $rb = HTML::table_row_builder([qw/foo/]);
$rb->({foo => 'bar', baz => 'blech'});
is($test, <<"_HTML_", "table row builder");
  <tr>
    <td>bar</td>
  </tr>
_HTML_

undef $test;
open STDOUT, ">", \$test or die "Can't open STDOUT: $!";

@rows = ({ foo => 'bar' });
$tb = HTML::table_builder($rb, sub { shift @rows });
HTML::to_html("Frank", $tb);
is($test, <<"_HTML_", "table row builder");
<html>
<head>
<title>Frank</title>
</head>

<body>
<table>
  <tr>
    <td>bar</td>
  </tr>
</table>
</body>
</html>
_HTML_
