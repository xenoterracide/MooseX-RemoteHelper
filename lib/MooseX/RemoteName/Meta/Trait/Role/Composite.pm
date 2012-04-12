package MooseX::RemoteName::Meta::Trait::Role::Composite;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

around apply_params => sub {
	my $orig = shift;
	my $self = shift;

	$self->orig(@_);

	$self = Moose::Util::MetaRole::apply_metaroles(
		for => $self,
		role_metaroles => {
			application_to_class =>
				['MooseX::RemoteName::Meta::Trait::Role::ApplicationToClass'],
			application_to_role =>
				['MooseX::RemoteName::Meta::Trait::Role::ApplicationToRole'],
		}
	);
	return $self;
};

1;
