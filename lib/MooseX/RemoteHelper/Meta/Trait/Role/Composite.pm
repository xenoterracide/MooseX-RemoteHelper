package MooseX::RemoteHelper::Meta::Trait::Role::Composite;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

around apply_params => sub {
	my $orig = shift;
	my $self = shift;

	$self->$orig(@_);

	$self = Moose::Util::MetaRole::apply_metaroles(
		for => $self,
		role_metaroles => {
			application_to_class =>
				['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToClass'],
			application_to_role =>
				['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToRole'],
		}
	);
	return $self;
};

1;

# ABSTRACT: called by MooseX::RemoteHelper::Meta::Trait::Role
