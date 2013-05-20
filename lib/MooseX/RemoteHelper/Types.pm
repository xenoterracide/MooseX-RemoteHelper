package MooseX::RemoteHelper::Types;
use strict;
use warnings;

# VERSION

use MooseX::Types    -declare => [qw( Bool TrueFalse )];
use MooseX::Types::Moose -all => { -prefix => 'Moose' };

enum TrueFalse, [qw( true false True False )];

subtype Bool, as MooseBool;
coerce  Bool, from TrueFalse,
	via {
		my $val = lc $_;
		if ( $val eq 'true' ) {
			return 1;
		}
		return 0;
	};

1;
# ABSTRACT: Common Type Coercions
