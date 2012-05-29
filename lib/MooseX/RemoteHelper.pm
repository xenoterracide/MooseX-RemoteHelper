package MooseX::RemoteHelper;
use 5.008;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose 2 ();
use Moose::Exporter;
use MooseX::RemoteHelper::Meta::Trait::Attribute;

Moose::Exporter->setup_import_methods(
	class_metaroles => {
		attribute => ['MooseX::RemoteHelper::Meta::Trait::Attribute'],
		class     => ['MooseX::RemoteHelper::Meta::Trait::Class'    ],
	},
	role_metaroles => {
		role =>
			['MooseX::RemoteHelper::Meta::Trait::Role']
			,
		application_to_class =>
			['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToClass']
			,
		application_to_role =>
			['MooseX::RemoteHelper::Meta::Trait::Role::ApplicationToRole']
			,
		applied_attribute =>
			['MooseX::RemoteHelper::Meta::Trait::Attribute']
			,
	},
);

1;

# ABSTRACT: adds an attribute name to represent remote naming
# SEEALSO: MooseX::Aliases

=head1 SYNOPSIS

	{
		package Message;
		use Moose 2;
		with 'MooseX::RemoteHelper::CompositeSerialization';

		use MooseX::RemoteHelper;

		has bool => (
			remote_name => 'Boolean',
			isa         => 'Bool',
			is          => 'ro',
			serializer => sub {
				my ( $attr, $instance ) = @_;
				return $attr->get_value( $instance ) ? 'Y' : 'N';
			},

		);

		has foo_bar => (
			remote_name => 'FooBar',
			isa         => 'Str',
			is          => 'ro',
		);

		__PACKAGE__->meta->make_immutable;
	}

	my $message = Message->new({ Boolean => 1, foo_bar => 'Baz', });

	$message->bool;      # 1
	$message->serialize; # { Boolean => 'Y', FooBar => 'Baz' }

=head1 DESCRIPTION

Many Remote APIs have key names that don't look good in a perl API, such as
variants of camel case or even names that you don't want to use simply because
they are inconsistent with your Perl API. This module allows you to provide a
remote name on your attribute. We also allow you to use the remote name as an
C<init_arg> so that you can more easily construct a response from a remote
response.

How the attributes work is documented in
L<MooseX::RemoteHelper::Meta::Trait::Attribute>

for serialize read

L<MooseX::RemoteHelper::CompositeSerialization>

=head1 ACKNOWLEDGMENTS

Some of this code is based on or outright copied from L<MooseX::Aliases>

=over

=item * L<Chris Prather ( Perigrin )|https://metacpan.org/author/PERIGRIN>

for help getting the basics working and understanding what some of this code
does.

=back

=cut
