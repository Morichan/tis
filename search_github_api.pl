use strict;
use warnings;
use utf8;

use lib::GithubApiSearhcer;

&main;

sub main {
    my $name = $ARGV[0];

    my $gas = GithubApiSearcher->new;

    $gas->search_github_api_and_name_eq($name);
    my $version = $gas->search_tools_latest_version;

    print $version;
}
