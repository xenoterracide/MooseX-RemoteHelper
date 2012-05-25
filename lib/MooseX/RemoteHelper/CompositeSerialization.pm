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

				if ( blessed $value ) {
					$serialized{ $attr->remote_name }
						=  $value->serialize
						if $value->can('serialize')
						;
				}
				else {
					$serialized{ $attr->remote_name }
						= $attr->serialized( $self )
						;
				}
			}
		}
	}
	return \%serialized;
}

1;
# ABSTRACT: Serializing to hashref via Composite pattern
