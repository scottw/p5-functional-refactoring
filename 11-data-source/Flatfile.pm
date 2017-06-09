package Flatfile;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(row_iterator);

sub row_iterator {
    my $file = shift;
    open my $fh, "<", $file or die $!;

    return sub {
        my $line = <$fh> or return;
        chomp $line;
        return { map { split /=/, $_ } split /,/ => $line };
    };
}

1;
