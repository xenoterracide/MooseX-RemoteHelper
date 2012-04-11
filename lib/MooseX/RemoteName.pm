package MooseX::RemoteName;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose ();
use Moose::Exporter;
use MooseX::RemoteName::Meta::Trait::Attribute;

Moose::Exporter->setup_import_methods;

1;

# ABSTRACT: MooseX::RemoteName
