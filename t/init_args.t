use strict;
use warnings;
use Test::More;

{
	package Test;
	use Moose;
	use MooseX::RemoteName;

	has attr => (
		traits      => ['RemoteName'],
		remote_name => 'Attr',
		isa         => 'Str',
		is          => 'ro',
	);
}

my $t0 = Test->new({ Attr => 'foo' });

is $t0->attr, 'foo', 'attr matches';

done_testing;
