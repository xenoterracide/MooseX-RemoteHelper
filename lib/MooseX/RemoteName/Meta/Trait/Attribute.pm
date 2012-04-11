package MooseX::RemoteName::Meta::Trait::Attribute;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
Moose::Util::meta_attribute_alias 'RemoteName';

has remote_name => (
	predicate => 'has_remote_name',
	isa       => 'Str',
	is        => 'ro',
);

around initialize_instance_slot => sub {
	my $orig = shift;
	my $self = shift;

	my ( $meta_instance, $instance, $params ) = @_;

	return $self->orig(@_)
		unless $self->has_remote_name && $self->has_init_arg;

	$params->{ $self->init_arg }
		= delete $params->{ $self->remote_name }
		if $params->{ $self->remote_name }
		;

	$self->$orig(@_);
};

1;

# ABSTRACT: role applied to meta attribute
