use strict;
use warnings;
use Test::More;
use Test::Exception;

{
	package Test;
	use Moose;
	use MooseX::RemoteHelper;

	has attr => (
		remote_name => 'Attr',
		isa         => 'Int',
		is          => 'ro',
		required    => 1,
	);

	__PACKAGE__->meta->make_immutable;
}

lives_ok {
	Test->new({ Attr => 0 });
} 'false value lives';


done_testing;
