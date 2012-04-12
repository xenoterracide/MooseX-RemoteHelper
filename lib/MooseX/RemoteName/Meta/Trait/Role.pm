package MooseX::RemoteName::Meta::Trait::Role;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

sub composition_class_roles {
	return 'MooseX::RemoteName::Meta::Trait::Role::Composite'
}

1;

# ABSTRACT: meta role

=head1 DESCRIPTION

The meta role is needed for use with immutable classes
