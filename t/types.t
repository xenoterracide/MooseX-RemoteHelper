use strict;
use warnings;
use Test::More;
use Test::Method;
use Class::Load 0.20 'load_class';

{
	package Test;
	use Moose;
	use MooseX::RemoteHelper::Types qw( Bool );

	has test => (
		isa    => Bool,
		is     => 'rw',
		coerce => 1,
	);
}

my $t = new_ok( load_class('Test') );

method_ok $t, test => ['true'], 1;

done_testing;
