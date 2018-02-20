use strict;
use warnings;
use utf8;

use lib::GithubApiSearhcer;

=head1 NAME

search_github_api - gitHub$B$N(BAPI$B$rC!$$$F>pJs$r<hF@$7$^$9!#(B

=head1 SYNOPSIS

    $ perl search_github_api.pl SearchingToolName Option

    $ perl search_github_api.pl JUnit version
    r4.7.1

=cut

&main;



=head1 METHODS

=head2 main

main$B%a%=%C%I(B

L<select_search_mode>$B%5%V%k!<%A%s$rMxMQ$7$F!"MM!9$J>pJs$r<hF@$7$^$9!#(B

$B0z?t$H$7$F!"<!$N(B2$B$D$r<h$j$^$9!#(B

=over 4

=item 1

$B%D!<%kL>(B

=item 2

$B%*%W%7%g%s(B

=back

=cut

sub main {
    if (@ARGV < 2 and 2 < @ARGV) {
        print "";
        exit;
    }

    my $name = $ARGV[0];
    my $option = $ARGV[1];

    select_search_mode($name, $option);
}

=head2 select_search_mode

L<lib::GithubApiSearcher>$B$b$8$e!<$k$rMxMQ$7$F!"MM!9$J>pJs$r<hF@$7$^$9!#(B

$B0z?t$H$7$F!"<!$N(B2$B$D$r<h$j$^$9!#(B

=over 4

=item 1

$B%D!<%kL>(B

=item 2

$B%*%W%7%g%s(B

=back

$B%*%W%7%g%s$H$7$F<h$l$k0z?t$r!"<!$K<($7$^$9!#(B

=over 4

=item 1

C<version>

=back

=cut

sub select_search_mode {
    my $name = shift;
    my $option = shift;

    my $gas = GithubApiSearcher->new;

    $gas->search_github_api_and_name_eq($name);

    if ($option eq "version") {
        my $version = $gas->search_tools_latest_version;
        print $version;
    } elsif ($option eq "description") {
        my $description = $gas->search_tools_description;
        print $description;
    }
}

=head1 AUTHOR

Morichan

=head1 COPYRIGHT

=cut
