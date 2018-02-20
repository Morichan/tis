use strict;
use warnings;
use utf8;

use lib::GithubApiSearhcer;

=head1 NAME

search_github_api - gitHubのAPIを叩いて情報を取得します。

=head1 SYNOPSIS

    $ perl search_github_api.pl SearchingToolName Option

    $ perl search_github_api.pl JUnit version
    r4.7.1

=cut

&main;



=head1 METHODS

=head2 main

mainメソッド

L<select_search_mode>サブルーチンを利用して、様々な情報を取得します。

引数として、次の2つを取ります。

=over 4

=item 1

ツール名

=item 2

オプション

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

L<lib::GithubApiSearcher>もじゅーるを利用して、様々な情報を取得します。

引数として、次の2つを取ります。

=over 4

=item 1

ツール名

=item 2

オプション

=back

オプションとして取れる引数を、次に示します。

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
