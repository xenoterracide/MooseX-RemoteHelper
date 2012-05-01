package MooseX::RemoteHelper::Meta::Trait::Attribute;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
Moose::Util::meta_attribute_alias 'RemoteHelper';

has remote_name => (
	predicate => 'has_remote_name',
	isa       => 'Str',
	is        => 'ro',
);

has serializer => (
	predicate => 'has_serializer',
	traits    => ['Code'],
	is        => 'ro',
	default   => sub {
		return sub {
			my ( $self, $instance ) = @_;
			return $self->get_value( $instance );
		}
	},
	handles   => {
		serializing => 'execute_method',
	},
);

sub serialized {
	my ( $self, $instance ) = @_;

	return $self->serializing( $instance );
}

around initialize_instance_slot => sub {
	my $orig = shift;
	my $self = shift;

	my ( $meta_instance, $instance, $params ) = @_;

	return $self->$orig(@_)
		unless $self->has_remote_name ## no critic ( ControlStructures::ProhibitNegativeExpressionsInUnlessAndUntilConditions )
			&& $self->has_init_arg
			&& $self->remote_name ne $self->init_arg
			;

	$params->{ $self->init_arg }
		= delete $params->{ $self->remote_name }
		if defined $params->{ $self->remote_name }
		;

	$self->$orig(@_);
};

1;

# ABSTRACT: role applied to meta attribute

=method serialized

returns the attributed value by using the L<serializer|/serializer>.

=attr remote_name

the name of the attribute key on the remote host

=attr serializer

a code ref for converting the real value to what the remote host expects

=cut
