package HTML;
use feature 'say';

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(to_html);

sub to_html {
    my %args = @_;

    html_start(%args);

    $args{sth}->execute;

    say "<table>";
    while (my $row = $args{sth}->fetchrow_hashref) {
        say "  <tr>";
        say "    <td>" . $row->{id} . "</td>";
        say "    <td>" . $row->{name} . "</td>";
        if ($args{title} =~ /customer/i) {
            say "    <td>" . $row->{email} . "</td>";
        }
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

1;
