# -------------------------------------------------------------------------------------
# MKDoc::XML::Decode
# -------------------------------------------------------------------------------------
# Author : Jean-Michel Hiver <jhiver@mkdoc.com>.
# Copyright : (c) MKDoc Holdings Ltd, 2003
#
# This modules expands XML entities &amp; &gt; &lt; &quot; and &apos;.
#
# This module is distributed under the same license as Perl itself.
# -------------------------------------------------------------------------------------
package MKDoc::XML::Decode;
use warnings;
use strict;


##
# $class->process ($xml);
# -----------------------
# Expands the entities &apos; &quot; &gt; &lt; and &amp;
# into their ascii equivalents.
##
sub process
{
    (@_ == 2) or warn "MKDoc::XML::Encode::process() should be called with two arguments";
    
    my $class = shift;
    my $data = join '', @_;
    $data =~ s/\&apos;/\'/g;
    $data =~ s/\&quot;/\"/g;
    $data =~ s/\&gt;/\>/g;
    $data =~ s/\&lt;/\</g;
    $data =~ s/\&amp;/\&/g;
    return $data;
}


1;


__END__


=head1 NAME

MKDoc::XML::Decode - Expands XML entities


=head1 SYNOPSIS

  use MKDoc::XML::Decode;

  # $xml is now "Chris' Baloon"
  my $xml = MKDoc::XML::Decode->process ("Chris&apos; Baloon");


=head1 SUMMARY

MKDoc::XML::Decode is a very simple module which decodes the following entities.

  &apos;
  &quot;
  &gt;
  &lt;
  &amp;

That's it. If you also wish to decode HTML entities, use it in conjunction with
L<MKDoc::XML::DecodeHO>.

This module and its counterpart L<MKDoc::XML::Encode> are used by L<MKDoc::XML::Dumper>
to XML-encode and XML-decode litterals.


=head1 API

=head2 my $decoded = MKDoc::XML::Decode->process ($xml_litteral);

Does what is said in the summary.


=head1 AUTHOR

Copyright 2003 - MKDoc Holdings Ltd.

Author: Jean-Michel Hiver <jhiver@mkdoc.com>

This module is free software and is distributed under the same license as Perl
itself. Use it at your own risk.


=head1 SEE ALSO

L<MKDoc::XML::DecodeHO>
L<MKDoc::XML::Encode>

=cut
