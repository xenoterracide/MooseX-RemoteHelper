package MooseX::RemoteHelper::Types;
use strict;
use warnings;

# VERSION

use MooseX::Types    -declare => [qw( Bool TrueFalse )];
use MooseX::Types::Moose -all => { -prefix => 'Moose' };

subtype TrueFalse, as MooseStr,
	where {
		$_ =~ m/^(true|t|f|false)$/ixms;
	};

subtype Bool, as MooseBool;
coerce  Bool, from TrueFalse,
	via {
		my $val = lc $_;
		if ( $val =~ m/^t/xms ) {
			return 1;
		}
		return 0;
	};

1;
# ABSTRACT: Common Type Coercions
