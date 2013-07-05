package MooseY::RemoteHelper::Role::Client;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

requires 'submit';

has $_ => (
	isa      => 'Str',
	is       => 'ro',
	required => 1,
) foreach qw( user pass );

has debug => (
	isa      => 'Int',
	is       => 'ro',
	lazy     => 1,
	default  => sub { $ENV{REMOTE_CLIENT_DEBUG} || 0 },
);

has test  => (
	isa       => 'Bool',
	traits    => [ 'Bool' ],
	is        => 'ro',
	lazy      => 1,
	default   => 1,
);

1;
# ABSTRACT: Commonly used attributes for remote facade's

=head1 SYNOPSIS

	# implementers
	use Moose;
	use Class::Load 0.20 'load_class';

	with 'MooseY::RemoteHelper::Role::Client';

	sub submit {
		my ( $self, $req ) = @_;

		# check test
		# check debug and output request/response
		# ...

		my $res; # = ...

		return $res;
	}

	# consumers debbuging live transactions
	my $req; # your request object

	my $client
		= load_class('My::Client')->new({
			user  => 'Str',
			pass  => 'Str',
			test  => 0,
			debug => 1,
		});

	my $res = try { $client->submit( $req ) } catch { ... if $_->does('Throwable') };

=head1 DESCRIPTION

I've found that most remote clients have the same things in common, L</user>,
L</pass>, a way to transmit L</submit>, need for L</debug> modes, and
commonly a L</test> mode.

=method submit

	my $res = try { $client->submit( $req ) } catch { ... if $_->does('Throwable') };

The above is the method signature this should implement. Submit should take a
request object that can serialize and return a response object. L<Throwable> exceptions
should occur if there is a network transmission error.

Note: the sample usage here is not good, write your exception handling better than this.

=attr user

Type: Str
Required

This should be the username or other credential used to identify your user.

=attr pass

Type: Str
Required

This should be the password, passphrase, or other credential used to
authenticate your user initially. If for some reason your client doesn't have
this, set it to an empty string and ignore it in L</submit> method.

=attr debug

Type: Int
Default: C<$ENV{REMOTE_CLIENT_DEBUG}> or C<0>

This is used to provide debugging levels, it defaults to the Environment
variable C<REMOTE_CLIENT_DEBUG> or 0 if that's not set.

=attr test

Type: Bool
Default: C<1>

Many remote APIs have a test mode, that is different from live transactions.
Use this to turn that on. It could toggle a different endpoint, or simply a
parameter. Defaults to C<1> because it's better to send fake requests than
accidentally send live ones. Remember to always set this on APIs that use it.
