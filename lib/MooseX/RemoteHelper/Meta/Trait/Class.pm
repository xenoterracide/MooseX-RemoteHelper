package MooseX::RemoteHelper::Meta::Trait::Class;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

around _inline_slot_initializer => sub {
	my $orig = shift;
	my $self = shift;
	my ( $attr, $index ) = @_;

	my @orig_source = $self->$orig(@_);

	return @orig_source
		unless $attr->meta->can('does_role')
			&& $attr->meta->does_role('MooseX::RemoteHelper::Meta::Trait::Attribute')
			;

	return $self->$orig(@_)
		unless $attr->has_remote_name ## no critic ( ControlStructures::ProhibitNegativeExpressionsInUnlessAndUntilConditions )
			&& $attr->has_init_arg
			&& $attr->remote_name ne $attr->init_arg
			;

	my $init_arg = $attr->init_arg;

	return (
		' $params->{' . $init_arg . '} '
		. ' = delete $params->{' .  $attr->remote_name . '} '
		. ' if defined $params->{' . $attr->remote_name . '}; '
		, @orig_source
		)
		;
};

1;
# ABSTRACT: meta class for immutable objects
