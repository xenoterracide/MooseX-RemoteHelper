package MooseX::RemoteHelper::Meta::Trait::Role;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

sub composition_class_roles {
	return 'MooseX::RemoteHelper::Meta::Trait::Role::Composite'
}

1;

# ABSTRACT: meta role

=method composition_class_roles

See L<Moose::Meta::Role/Construction>

=cut
