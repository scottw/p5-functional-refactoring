package HTML;
use feature 'say';

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(to_html table_row_builder);

sub to_html {
    my %args = @_;

    html_start(%args);

    $args{sth}->execute;

    say "<table>";
    while (my $row = $args{sth}->fetchrow_hashref) {
        $args{row_builder}->($row);
    }
    say "</table>";

    html_end();
}

sub table_row_builder {
    my $columns = shift;

    return sub {
        my $row = shift;

        say "  <tr>";
        for my $col (@$columns) {
            say "    <td>" . $row->{$col} . "</td>";
        }
        say "  </tr>";
    };
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
