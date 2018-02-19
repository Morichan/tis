package GithubApiSearcher;

use lib "/home/ubuntu/perl5/lib/perl5/";
use lib "/home/ubuntu/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/";

use Mouse;
use JSON;

has url => (is => "rw", default => "https://api.github.com/search/repositories?q=");
has release_url => (is => "rw", default => "https://apt.github.com/repos/");
has json_data => (is => "rw");

sub search_github_api_and_name_eq {
    my $self = shift;
    my $name = shift;

    $self->add_url_and_name($name);
    $self->format_json_from_github_apt($self->url);
    my $full_name = $self->json_data->{items}[0]{full_name};
    $self->release_url($self->release_url . $full_name);

    return ;
}

sub add_url_and_name {
    my $self = shift;
    my $name = shift;

    $self->url($self->url . $name);
}

sub format_json_from_github_apt {
    my $self = shift;
    my $searching_url = shift;

    my $json_plane_text = `curl $searching_url`;
    my $json_data decode_json($json_plane_text);
    $self->json_data($json_data);
}

1;
