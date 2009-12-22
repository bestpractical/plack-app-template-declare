package Plack::App::Template::Declare;
use strict;
use warnings;
use parent 'Plack::Component';
use Plack::Util;
use Template::Declare;

use Plack::Util::Accessor qw(view args);

sub new {
    my $self = shift->SUPER::new(@_);
    $self->init;
    return $self;
}

sub init {
    my $self = shift;
    my $view = $self->view;
    $view = [$view] if !ref($view);
    Template::Declare->init(dispatch_to => $view);
}

sub should_handle {
    my ($self, $path) = @_;
    return Template::Declare->has_template($path);
}

sub call {
    my $self = shift;
    my $env  = shift;

    my $path = $env->{PATH_INFO};

    if (!$self->should_handle($path)) {
        return $self->return_404;
    }

    return $self->serve_path($env, $path);
}

sub args_for_show {
    my $self = shift;
    my $env  = shift;

    return @{ $self->args };
}

sub serve_path {
    my $self = shift;
    my $env  = shift;
    my $path = shift;

    my $body = Template::Declare->show($path, $self->args_for_show($env));

    return [
        200,
        [],
        [$body],
    ];
}

sub return_404 {
    my $self = shift;
    return [404, ['Content-Type' => 'text/plain'], ['not found']];
}

1;

