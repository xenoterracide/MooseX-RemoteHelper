use strict;
use warnings;
use Test::More;
use Test::Moose;

{
	package Test0;
	use Moose;
	extends 'MooseY::RemoteHelper::MessagePart';

	has attr => (
		remote_name => 'attribute',
		isa         => 'Str',
		is          => 'ro',
	);

	__PACKAGE__->meta->make_immutable;
}

my $t0 = new_ok 'Test0' => [{ attribute => 'foo' }];
my $t1 = new_ok 'Test0' => [{ attribute => undef }];

is $t0->attr, 'foo', 'attribute correct';
is $t1->attr, undef, 'attribute correct';

done_testing;
