#!/usr/bin/perl
use lib qw (../lib lib);
use Test::More 'no_plan';
use strict;
use warnings;
use MKDoc::XML::DecodeHO;

# those should be unchanged
is (MKDoc::XML::DecodeHO->process ('Hello, &lt;'), 'Hello, &lt;');
is (MKDoc::XML::DecodeHO->process ('Hello, &gt;'), 'Hello, &gt;');
is (MKDoc::XML::DecodeHO->process ('Hello, &amp;'), 'Hello, &amp;');
is (MKDoc::XML::DecodeHO->process ('Hello, &quot;'), 'Hello, &quot;');
is (MKDoc::XML::DecodeHO->process ('Hello, &apos;'), 'Hello, &apos;');

# but these should be
isnt (MKDoc::XML::DecodeHO->process ('&nbsp;'), '&nbsp;');

# add your own here :)


1;


__END__
