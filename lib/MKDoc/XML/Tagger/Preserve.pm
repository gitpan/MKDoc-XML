# -------------------------------------------------------------------------------------
# MKDoc::XML::Tagger::Preserve
# -------------------------------------------------------------------------------------
# Author : Jean-Michel Hiver <jhiver@mkdoc.com>.
# Copyright : (c) MKDoc Holdings Ltd, 2003
#
# This module uses MKDoc::XML::Tagger, except it preserves specific tags to prevent
# them from being tagged twice. At the moment the module uses regexes to do that so it
# might not be very generic but it should at least work for XHTML <a> tags.
# -------------------------------------------------------------------------------------
package MKDoc::XML::Tagger::Preserve;
use MKDoc::XML::Tagger;
use strict;
use warnings;
use utf8;

our @Preserve = ();


##
# $class->process_data ($xml, @expressions);
# ------------------------------------------
# Tags $xml with @expressions, where expression is a list of hashes.
#
# For example:
#
# MKDoc::XML::Tagger::Preserve->process (
#     [ 'i_will_be_preserved', 'a' ],
#     'I like oranges and bananas',
#     { _expr => 'oranges', _tag => 'a', href => 'http://www.google.com?q=oranges' },
#     { _expr => 'bananas', _tag => 'a', href => 'http://www.google.com?q=bananas' },
#
# Will return
#
# 'I like <a href="http://www.google.com?q=oranges">oranges</a> and \
# <a href="http://www.google.com?q=bananas">bananas</a>.
##
sub process_data
{
    my $class = shift;
    local @Preserve = @{shift()};
    my $text  = shift;
    my @list  = ();


    ($text, @list) = _preserve_encode ($text);
    $text          = MKDoc::XML::Tagger->process_data ($text, @_);
    $text          = _preserve_decode ($text, @list);

    return $text;
}


sub process_file
{
    my $class = shift;
    my $file  = shift;
    open FP, "<$file" || do {
        warn "Cannot read-open $file";
        return [];
    };
    
    my $data = '';
    while (<FP>) { $data .= $_ }
    close FP;
    
    return $class->process_data ($data);
}


sub _preserve_encode
{
    my $text = shift;
    my @list = ();
    for my $tag (@Preserve)
    {
        my @tags = $text =~ /(<$tag\s.*?<\/$tag>)/gs;
        for my $tag (@tags) { while ($text =~ s/\Q$tag\E/_compute_unique_string ($text, $tag, \@list)/e) {} }
    }
    
    return $text, @list;
}


sub _preserve_decode
{
    my $text = shift; 
    my @tsil = reverse (@_);
    
    while (@tsil)
    {
        my $val = shift (@tsil);
        my $id  = shift (@tsil);
        $text =~ s/$id/$val/; 
    }
    
    return $text;
}


sub _compute_unique_string
{
    my $text = shift;
    my $str  = shift;
    my $list = shift;
    my $id   = join '', map { chr (ord ('a') + int (rand (26))) } 1..10;
    while ($text =~ /\Q$id\E/)
    {
        $id = join '', map { chr (ord ('a') + int (rand (26))) } 1..10;
    }
    
    push @{$list}, $id => $str;
    return $id;
}


1;


__END__


=head1 NAME

MKDoc::XML::Tagger::Preserve - Don't double-tag stuff.


=head1 SYNOPSIS

  use MKDoc::XML::Tagger::Preserve;
  print MKDoc::XML::Tagger->process_data (
      [ a ]
      "Hello, <a>Cool World</a>. This World is tagged.",
      { _expr => 'World', _tag => 'strong', class => 'superFort' }
  );

Should print:

  Hello, <a>Cool World</a>. This <strong class="superFort">World</strong> is tagged.


=head1 SUMMARY

MKDoc::XML::Tagger::Preserve does the same thing as MKDoc::XML::Tagger except
it lets you define which tags you don't want to be tagged.

Let's say that you have an XHTML fragment with some hyperlinks in it. You want
to hyperlink this fragment, but, of course, you do not want the content of the
existing hyperlinks to be hyperlinked again.


Instead of using MKDoc::XML::Tagger:

  return MKDoc::XML::Tagger->process ($fragment, @links);


You use MKDoc::XML::Tagger::Preserve:

  return MKDoc::XML::Tagger::Preserve->process ( [ 'a' ], $fragment, @links);


=head1 DISCLAIMER

B<This module does low level XML manipulation. It will somehow parse even broken XML
and try to do something with it. Do not use it unless you know what you're doing.>


=head1 NOTES

Don't expect L<MKDoc::XML::Tagger::Preserve> to do anything clever with tags
which have nested tags in them, i.e. tags such as <small>.

L<MKDoc::XML::Tagger::Preserve> uses a very simple regex to take the tags which
you want to preserve out so with nested <small> for example, it's guaranteed to
fail and product incorrect XHTML.


=head1 AUTHOR

Copyright 2003 - MKDoc Holdings Ltd.

Author: Jean-Michel Hiver <jhiver@mkdoc.com>

This module is free software and is distributed under the same license as Perl
itself. Use it at your own risk.


=head1 SEE ALSO

L<MKDoc::XML::Tagger>


=cut
