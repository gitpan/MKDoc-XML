#!/usr/bin/perl
use lib qw (../lib lib);
use Test::More 'no_plan';
use strict;
use warnings;
use MKDoc::XML::Decode;

is (MKDoc::XML::Decode->process ('Hello, &lt;'), 'Hello, <');
is (MKDoc::XML::Decode->process ('Hello, &gt;'), 'Hello, >');
is (MKDoc::XML::Decode->process ('Hello, &amp;'), 'Hello, &');
is (MKDoc::XML::Decode->process ('Hello, &quot;'), 'Hello, "');
is (MKDoc::XML::Decode->process ('Hello, &apos;'), 'Hello, \'');


1;


__END__
