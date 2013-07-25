package MooseX::RemoteHelper::Types;
use strict;
use warnings;

# VERSION

use MooseX::Types    -declare => [qw( Bool TrueFalse )];
use MooseX::Types::Moose -all => { -prefix => 'Moose' };

subtype TrueFalse, as MooseStr,
	where {
		$_ =~ m/^(true|t|f|false|enable[d]?|disable[d]?)|yes|y|no|n$/ixms;
	};

subtype Bool, as MooseBool;
coerce  Bool, from TrueFalse,
	via {
		my $val = lc $_;
		if ( $val =~ m/^(t|enable|y)/xms ) {
			return 1;
		}
		elsif ( $val =~  /^(f|disable|n)/xms ) {
			return 0;
		}
		return 0;
	};

1;
# ABSTRACT: Types to help with things commonly needed by remotes

=sub Bool

coerces from string where values could match (case insensitive):

	true, t, false, f, enable[d], disable[d], yes, y, no, n
