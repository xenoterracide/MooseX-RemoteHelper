package MooseX::RemoteHelper::CompositeSerialization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use Safe::Isa;

sub serialize {
	my $self = shift;

	my %serialized;

	foreach my $attr ( $self->meta->get_all_attributes ) {
		if ( $attr->does('RemoteHelper')
				# check if we can get a value
				&& ( $attr->has_value( $self )
					|| $attr->has_default
					|| $attr->has_builder
				)
			) {
			if ( $attr->has_remote_name ) {
				my $value = $attr->get_value( $self );

				# we need to be able to return an explicit undef
				# run recursively on an sub object that can do this
				# skip object's that have no way of serializing
				# and handle non object leafs simply
				if ( $attr->has_serializer ) {
					$serialized{ $attr->remote_name }
						= $attr->serialized( $self )
						;
				}
				# is the value a composite object?
				# is it just a plain old object?
				# check for serialize and run that
				elsif ( $value->$_can('serialize') ) {
					$serialized{ $attr->remote_name } = $value->serialize;
				}
				elsif ( ref $value eq 'ARRAY' ) {
					# let's try to handle array refs of objects if we know
					# that's what they are
					if ( $attr->has_type_constraint
						&& $attr->type_constraint->is_subtype_of('ArrayRef')
						&& ( $attr->type_constraint
								->type_parameter
								->is_subtype_of('Object')
							|| $attr->type_constraint
								->type_parameter
								->is_a_type_of('Object')
						)
					) {
						$serialized{ $attr->remote_name }
							= [
								map { $_->can('serialize') ? $_->serialize : () }
								@{ $value }
							 ];
					}
				}
				else {
				# value not blessed just return the leaf
					$serialized{ $attr->remote_name }
						= $value
						unless blessed $value
						;
				}
			}
		}
	}
	return \%serialized;
}

1;
# ABSTRACT: Serialize object recursively

=head1 SYNOPSIS

	{
	package MessagePart;
		use Moose 2;
		use MooseX::RemoteHelper;
		with 'MooseX::RemoteHelper::CompositeSerialization';

		has array => (
			remote_name => 'SomeColonDelimitedArray',
			isa         => 'ArrayRef',
			is          => 'ro',
			serializer => sub {
				my ( $attr, $instance ) = @_;
				return join( ':', @{ $attr->get_value( $instance ) } );
			},
		);

		__PACKAGE__->meta->make_immutable;
	}

	{
	package Message;
		use Moose 2;
		use MooseX::RemoteHelper;

		with 'MooseX::RemoteHelper::CompositeSerialization';

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

		has part => (
			isa         => 'MessagePart',
			remote_name => 'MyMessagePart',
			is          => 'ro',
		);

		__PACKAGE__->meta->make_immutable;
	}

	my $message
		= Message->new({
			bool    => 0,
			foo_bar => 'Baz',
			part    => MessagePart->new({ array => [ qw( 1 2 3 4 ) ] }),
		});

	$message->serialize;

	# {
	#   Boolean => "N",
	#   FooBar => "Baz",
	#   MyMessagePart => { SomeColonDelimitedArray => "1:2:3:4" }
	# }

=head1 DESCRIPTION

Recursively serialize to hashref based on the
L<Composite Pattern|http://en.wikipedia.org/wiki/Composite_pattern>. It's
intended to allow easy passing of a plain old perl data structure to a
serialization module like L<JSON> or L<YAML>.

=method serialize

serialize to a perl hashref

=cut
