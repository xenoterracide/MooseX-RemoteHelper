package MooseX::RemoteName;
use 5.008;
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

# ABSTRACT: adds an attribute name to represent remote naming

=head1 SYNOPSIS

	{
		package Message;
		use Moose 2;
		use MooseX::RemoteName;

		has attr => (
			remote_name => 'Attr',
			isa         => 'Str',
			is          => 'ro',
		);
		__PACKAGE__->meta->make_immutable;
	}

	my $message = Message->new({ Attr => 'foo' });

	print $message->attr . "\n"; # foo

=head1 DESCRIPTION

Many Web APIs have key names that don't look good in a perl API, such as
variants of camel case or even names that you don't want to use simply because
they are inconsistent with your Perl API. This module allows you to provide a
remote name on your attribute. We also allow you to use the remote name as an
C<init_arg> so that you can more easily construct a response from a remote
response.

=cut
