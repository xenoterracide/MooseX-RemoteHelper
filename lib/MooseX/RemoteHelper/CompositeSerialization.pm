package MooseX::RemoteHelper::CompositeSerialization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

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

				# value not blessed just return the leaf
				if ( $attr->has_serializer ) {
					$serialized{ $attr->remote_name }
						= $attr->serialized( $self )
						;
				}
				# is the value a composite object?
				# we should recursively run this on it
				elsif ( blessed $value && $value->can('serialize') ) {
					$serialized{ $attr->remote_name } = $value->serialize;
				}
				# is it just a plain old object?
				# check for a serializer and run that, or ignore
				else {
					$serialized{ $attr->remote_name }
						= $value
						if ! blessed $value
						;
				}
			}
		}
	}
	return \%serialized;
}

1;
# ABSTRACT: Serializing to hashref via Composite pattern

=method serialize

to_json( $obj->serialize )

Recursive serialize to hashref based on the Composite Pattern. Should allow
easy passing of object to a real serializer.

=cut
