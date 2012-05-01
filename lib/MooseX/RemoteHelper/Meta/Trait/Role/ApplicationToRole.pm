package MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToRole;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

around apply => sub {
	my $orig = shift;
	my $self = shift;
	my ( $role1 , $role2 ) = @_;

	$role2 = Moose::Util::MetaRole::apply_metaroles(
		for => $role2,
		role_metaroles => {
			application_to_class =>
				['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToClass']
			,
			application_to_role  =>
				['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToRole']
			,
		},
	);

	$self->$orig( $role1, $role2 );
};

1;

# ABSTRACT: For Roles applied to Roles
