# -------------------------------------------------------------------------------------
# MKDoc::XML::Token
# -------------------------------------------------------------------------------------
# Author : Jean-Michel Hiver <jhiver@mkdoc.com>.
# Copyright : (c) MKDoc Holdings Ltd, 2003
#
# This class represents a token objects as returned by MKDoc::XML::Tokenizer.
#
# This module is distributed under the same license as Perl itself.
# -------------------------------------------------------------------------------------
package MKDoc::XML::Token;
use strict;
use warnings;


##
# $class->new ($string_token);
# ----------------------------
# Instantiates a new MKDoc::XML::Token object with the value
# $string_token.
##
sub new
{
    my $class = shift;
    my $token = shift;
    return bless \$token, $class;
}


##
# $self->as_string();
# -------------------
# Returns a string representation of this token object.
##
sub as_string
{
    my $self = shift;
    return $$self;
}


##
# $self->is_leaf();
# -----------------
# Returns a TRUE value (a hashref representing this token
# as a node) if this $token is not an opening or a closing tag,
# undef otherwise.
##
sub is_leaf
{
    my $self = shift;
    return $self->is_comment()        ||
           $self->is_declaration()    ||
	   $self->is_pi()             ||
	   $self->is_tag_self_close() ||
	   $self->is_text();
}


##
# $self->_token_is_pseudotag();
# -----------------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if this $token is a comment, declaration, or
# processing instruction, undef otherwise.
##
sub is_pseudotag
{
    my $self = shift;
    return $self->is_comment()     ||
           $self->is_declaration() ||
	   $self->is_pi();
}


##
# $self->is_tag();
# ----------------
# Returns a TRUE value (a hashref representing this token
# as a node) if this $token is an opening, closing, or
# self-closing tag. Returns undef otherwise.
##
sub is_tag
{
    my $self = shift;
    return $self->is_tag_open()  ||
           $self->is_tag_close() ||
	   $self->is_tag_self_close();
}


##
# $class->is_comment();
# ---------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if this $token is a comment, undef otherwise.
##
sub is_comment
{
    my $self = shift;
    my $node = undef;
    $$self =~ /^<\!--/ and do {
	$node = {
	    _tag => '~comment',
	    text => $$self,
	};
	$node->{text} =~ s/^<\!--//;
	$node->{text} =~ s/-->$//;
    };
    $node;
}


##
# $self->is_declaration();
# ------------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is a declaration, undef otherwise.
##
sub is_declaration
{
    my $self = shift;
    my $node = undef;
    $$self !~ /^<\!--/ and $$self =~ /^<!/ and do {
	$node = {
	    _tag => '~declaration',
	    text => $$self,
	};
	$node->{text} =~ s/^<!//;
	$node->{text} =~ s/>$//;
    };
    $node;
}


##
# $self->is_pi();
# ---------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is a processing instruction, undef
# otherwise.
##
sub is_pi
{
    my $self = shift;
    my $node = undef;
    $$self =~ /^<\?/ and do {
	$node = {
	    _tag => '~pi',
	    text => $$self,
	};
	$node->{text} =~ s/^<\?//;
	$node->{text} =~ s/\>$//;
	$node->{text} =~ s/\?$//;
    };
    $node;
}


##
# $self->is_tag_open();
# ---------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is an opening tag, undef otherwise.
##
sub is_tag_open
{
    my $self = shift;
    my $node  = undef;
    $$self !~ /^<\!/ and
    $$self !~ /^<\// and
    $$self !~ /\/>$/ and
    $$self !~ /^<\?/ and    
    $$self =~ /^</   and do {
	my %node      = ($$self =~ /((?:\w|:)+)=\"(.*?)\"/gs), ($$self =~ /((?:\w|:)+)=\'(.*?)\'/gs);
	($node{_tag}) = $$self =~ /.*?([A-Za-z0-9][A-Za-z0-9_:-]*)/;
	$node{_open}  = 1;
	$node{_close} = 0;
	$node = \%node;
    };
    
    $node;
}


##
# $self->is_tag_close();
# ----------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is a closing tag, undef otherwise.
##
sub is_tag_close
{
    my $self = shift;
    my $node  = undef;
    $$self !~ /^<\!/ and
    $$self =~ /^<\// and
    $$self !~ /\/>$/ and do {
	my %node      = ($$self =~ /((?:\w|:)+)=\"(.*?)\"/gs), ($$self =~ /((?:\w|:)+)=\'(.*?)\'/gs);
	($node{_tag}) = $$self =~ /.*?([A-Za-z0-9][A-Za-z0-9_:-]+)/;
	$node{_open}  = 0;
	$node{_close} = 1;
	$node = \%node;
    };
    
    $node;
}


##
# $class->_token_tag_self_close ($$self);
# ---------------------------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is a self-closing tag, undef otherwise.
##
sub is_tag_self_close
{
    my $self = shift;
    my $node  = undef;
    $$self !~ /^<\!/ and
    $$self !~ /^<\// and
    $$self =~ /\/>$/ and
    $$self =~ /^</   and do {
	my %node      = ($$self =~ /((?:\w|:)+)=\"(.*?)\"/gs), ($$self =~ /((?:\w|:)+)=\'(.*?)\'/gs);
	($node{_tag}) = $$self =~ /.*?([A-Za-z0-9][A-Za-z0-9_:-]+)/;
	$node{_open}  = 1;
	$node{_close} = 1;
	$node = \%node;
    };
    
    $node;
}


##
# $class->_token_is_text ($$self);
# --------------------------------
# Returns a TRUE value (a hashref representing this token
# as a node) if $self is a text tag, undef otherwise.
##
sub is_text
{
    my $self = shift;
    return ($$self !~ /^</) ? $$self : undef;
}


1;


__END__


=head1 NAME

MKDoc::XML::Token - XML Token Object



=head1 SYNOPSIS

  my $tokens = MKDoc::XML::Tokenizer->process_data ($some_xml);
  foreach my $token (@{$tokens})
  {
      print "'" . $token->as_string() . "' is text\n" if (defined $token->is_text());
      print "'" . $token->as_string() . "' is a self closing tag\n" if ($token->is_tag_self_close());
      print "'" . $token->as_string() . "' is an opening tag\n" if ($token->is_tag_open());
      print "'" . $token->as_string() . "' is a closing tag\n" if ($token->is_tag_close());
      print "'" . $token->as_string() . "' is a processing instruction\n" if ($token->is_pi());
      print "'" . $token->as_string() . "' is a declaration\n" if ($token->is_declaration());
      print "'" . $token->as_string() . "' is a comment\n" if ($token->is_comment());
      print "'" . $token->as_string() . "' is a tag\n" if ($token->is_tag());
      print "'" . $token->as_string() . "' is a pseudo-tag (NOT text and NOT tag)\n" if ($token->is_pseudotag());
      print "'" . $token->as_string() . "' is a leaf token (NOT opening tag)\n" if ($token->is_leaf());
  }



=head1 SUMMARY

L<MKDoc::XML::Token> is an object representing an XML token produced by L<MKDoc::XML::Tokenizer>.

It has a set of methods to identify the type of token it is, as well as to help building a parsed
tree as in L<MKDoc::XML::TreeBuilder>.



=head1 API


=head2 my $token = new MKDoc::XML::Token ($string_token);

Constructs a new MKDoc::XML::Token object.


=head2 my $as_string = $token->as_string();

Returns this token object as a string object.


=head2 my $node = $token->is_text();

If this token object represents a piece of text, then this text is returned.
Returns undef otherwise.


=head2 my $node = $token->is_tag_open();

If this token object represents an opening tag, the following structure
is returned:

  # this is <aTag foo="bar" baz="buz">
  {
      _tag   => 'aTag',
      _open  => 1,
      _close => 0,
      foo    => 'bar',
      baz    => 'buz',
  }

Returns undef otherwise.


=head2 my $node = $token->is_tag_close();

If this token object represents a closing tag, the following structure
is returned:

  # this is </aTag>
  {
      _tag   => 'aTag',
      _open  => 0,
      _close => 1,
  }

Returns undef otherwise.


=head2 my $node = $token->is_tag_self_close();

If this token object represents a self-closing tag, the following structure
is returned:

  # this is <aTag foo="bar" baz="buz" />
  {
      _tag   => 'aTag',
      _open  => 1,
      _close => 1,
      foo    => 'bar',
      baz    => 'buz',
  }

Returns undef otherwise.


=head2 my $node = $token->is_pi();

If this token object represents a processing instruction, the following structure
is returned:

  # this is <?xml version="1.0" charset="UTF-8"?>
  {
      _tag   => '~pi',
      text   => 'xml version="1.0" charset="UTF-8"',
  }

Returns undef otherwise.


=head2 my $node = $token->is_declaration();

If this token object represents a declaration, the following structure
is returned:

  # this is <!DOCTYPE foo>
  {
      _tag   => '~declaration',
      text   => 'DOCTYPE foo',
  }

Returns undef otherwise.


=head2 my $node = $token->is_comment();

If this token object represents a declaration, the following structure
is returned:

  # this is <!-- I like Pie. Pie is good -->
  {
      _tag   => '~comment',
      text   => ' I like Pie. Pie is good ',
  }
  
Returns undef otherwise.


=head2 my $node = $token->tag();

If this token is an opening, closing, or self closing tag, this
method will return $token->tag_is_open(), $token->tag_is_close()
or $token->tag_is_self_close() resp.

Returns undef otherwise.


=head2 my $node = $token->is_peudotag();

If this token is a comment, declaration or processing instruction,
this method will return $token->tag_is_comment(), $token_is_declaration()
or $token->is_pi() resp.

Returns undef otherwise.


=head2 my $node = $token->is_leaf();

If this token is not an opening tag, this method will return its corresponding
node structure as returned by $token->is_text(), $token->is_tag_self_close(),
etc.

Returns undef otherwise.


=head2 my $string_token = $token->as_string();

Returns the string representation of this token so that:

  MKDoc::XML::Token->new ($token)->as_string eq $token

is a tautology.


=head1 NOTES

L<MKDoc::XML::Token> works with L<MKDoc::XML::Tokenizer>, which can be used
when building a full tree is not necessary. If you need to build a tree, look
at L<MKDoc::XML::TreeBuilder>.


=head1 AUTHOR

Copyright 2003 - MKDoc Holdings Ltd.

Author: Jean-Michel Hiver <jhiver@mkdoc.com>

This module is free software and is distributed under the same license as Perl
itself. Use it at your own risk.


=head1 SEE ALSO

L<MKDoc::XML::Tokenizer>
L<MKDoc::XML::TreeBuilder>


=cut
