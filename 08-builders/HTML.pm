package HTML;
use feature 'say';

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(to_html table_row_builder table_builder);

sub to_html {
    my ($title, $table_builder) = @_;

    html_start($title);

    $table_builder->();

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

sub table_builder {
    my $row_builder = shift;
    my $sth         = shift;

    $sth->execute;

    return sub {
        say "<table>";
        while (my $row = $sth->fetchrow_hashref) {
            $row_builder->($row);
        }
        say "</table>";
    };
}

sub html_start {
    my $title = shift;

    print <<"_START_";
<html>
<head>
<title>$title</title>
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
