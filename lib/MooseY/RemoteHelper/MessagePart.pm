package MooseY::RemoteHelper::MessagePart;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::RemoteHelper;
use MooseX::UndefTolerant;

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Base class for a part of a message

=head1 SYNOPSIS

	use Moose;
	extends 'MooseY::RemoteHelper::MessagePart';

=head1 DESCRIPTION

This is mostly useful for auto importing extenstions which are sane when
dealing with remote api's. Since I work with a lot of remote api's I got tired
of writing this class.
