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

1;

# ABSTRACT: role applied to meta attribute
