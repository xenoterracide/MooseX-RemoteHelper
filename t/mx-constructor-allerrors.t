use strict;
use warnings;
use Test::More;
use Test::Requires qw( MooseX::Constructor::AllErrors );

{
	package Test0;
	use Moose;
	use MooseX::RemoteHelper;
	use MooseX::Constructor::AllErrors;
	
	has attr => (
		isa         => 'Str',
		is          => 'ro',
		remote_name => 'Attribute',
		required    => 1,
	);
}
{
	package Test1;
	use Moose;
	extends 'Test0';
}

TODO: {
	local $TODO = 'Fix AllErrors';
	new_ok 'Test0' => [{ Attribute => 1 }];
	new_ok 'Test1' => [{ Attribute => 1 }];
}

done_testing;
