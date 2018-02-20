package GithubApiSearcher;

use lib "/home/ubuntu/perl5/lib/perl5/";
use lib "/home/ubuntu/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/";

use Mouse;
use JSON;

has searching_url => (is => "rw", default => "https://api.github.com/search/repositories?q=");
has release_url => (is => "rw", default => "https://api.github.com/repos/");
has searching_json_data => (is => "rw");
has release_json_data => (is => "rw");
has latest_release_version => (is => "rw");

sub search_github_api_and_name_eq {
    my $self = shift;
    my $name = shift;

    $self->add_searching_url_and_name($name);
    $self->searching_json_data(
        $self->format_json_from_github_apt($self->searching_url));
}

sub search_tools_latest_version {
    my $self = shift;

    my $full_name = $self->searching_json_data->{items}[0]{full_name};

    $self->add_release_url_and_name($full_name);
    $self->release_json_data(
        $self->format_json_from_github_apt($self->release_url));
    $self->latest_release_version(
        $self->release_json_data->[0]{tag_name});

    return $self->latest_release_version;
}

sub search_tools_description {
    my $self = shift;

    return $self->searching_json_data->{items}[0]{description};
}

sub add_searching_url_and_name {
    my $self = shift;
    my $name = shift;

    $self->searching_url($self->searching_url . $name);
}

sub add_release_url_and_name {
    my $self = shift;
    my $name = shift;

    $self->release_url($self->release_url . $name . "/releases");
}

sub format_json_from_github_apt {
    my $self = shift;
    my $searching_url = shift;

    my $json_plane_text = `curl $searching_url`;
    decode_json($json_plane_text);
}

1;
