package MooseX::RemoteName;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose 2 ();
use Moose::Exporter;
use MooseX::RemoteName::Meta::Trait::Attribute;

Moose::Exporter->setup_import_methods(
	class_metaroles => {
		attribute => ['MooseX::RemoteName::Meta::Trait::Attribute'],
		class     => ['MooseX::RemoteName::Meta::Trait::Class'    ],
	},
	role_metaroles => {
		role =>
			['MooseX::RemoteName::Meta::Trait::Role']
			,
		application_to_class =>
			['MooseX::RemoteName::Meta::Trait::Role::ApplicationToClass']
			,
		application_to_role =>
			['MooseX::RemoteName::Meta::Trait::Role::ApplicationToRole']
			,
		applied_attribute =>
			['MooseX::RemoteName::Meta::Trait::Attribute']
			,
	},
);

1;

# ABSTRACT: MooseX::RemoteName
