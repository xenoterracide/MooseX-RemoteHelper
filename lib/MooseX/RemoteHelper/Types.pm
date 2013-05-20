package MooseX::RemoteHelper::Types;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use MooseX::Types::Moose       qw( Str  );
use MooseX::Types -declare => [qw( Bool )];

enum TrueFalse, [qw( true false True False )];

subtype Bool, as MooseX::Types::Moose::Bool;
coerce  Bool, from TrueFalse;
    via {
        my $val = lc $_;
        if ( $val eq 'true' ) {
            return 1;
        }
        elsif ( $val eq 'false' ) {
            return 0;
        }
    };

# ABSTRACT: Common Type Coercions
