package MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToClass;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

around apply => sub {
	my $orig = shift;
	my $self = shift;
	my ( $role, $class ) = @_;

	$class = Moose::Util::MetaRole::apply_metaroles(
		for => $class,
		class_metaroles => {
			class => ['MooseX::RemoteHelper::Meta::Trait::Class']
		},
	);

	$self->$orig( $role, $class );
};

1;

# ABSTRACT: For Roles applied to Classes
