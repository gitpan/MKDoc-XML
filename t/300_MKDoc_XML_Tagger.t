#!/usr/bin/perl
use lib qw (../lib lib);
use Test::More 'no_plan';
use strict;
use warnings;
use MKDoc::XML::Tagger;
use MKDoc::XML::Tokenizer;

# _tag_close and _tag_open functions
{
    my $tag = MKDoc::XML::Tagger::_tag_close ('strong');
    is ($tag, '</strong>');
    
    $tag = MKDoc::XML::Tagger::_tag_open ('strong');
    is ($tag, '<strong>');
    
    $tag = MKDoc::XML::Tagger::_tag_open ('strong', { class => 'superFort' });
    is ($tag, '<strong class="superFort">');
}


# this regex should match any amount of consecutive whitespace,
# or \&(214) like tags, or carriage returns
{
    my $sample_text = <<EOF;
   \&(214) \&(214)
\&(22)  \&(214)  \&(33)
 \&(2142343432432) 
EOF

    if (0) { $MKDoc::XML::Tagger::Ignorable_RE = $MKDoc::XML::Tagger::Ignorable_RE } # no silly warnings
    my $re = '^' . $MKDoc::XML::Tagger::Ignorable_RE . '$';
    like ($sample_text, qr/$re/);
    unlike ('hello world', qr /$re/);
}


# _segregate_markup_from_text
{
    my $example = <<'EOF';
Abstract

The Extensible Markup Language (XML) is a subset of <strong>SGML</strong>
that is <a href="foo">completely described</a> in this document.
EOF
    
    my $tokens        = MKDoc::XML::Tokenizer->process_data ($example);
    my ($text, $tags) = MKDoc::XML::Tagger::_segregate_markup_from_text ($tokens);
    like ($text, qr/\&\(1\)SGML\&\(2\)/);
    like ($text, qr/\&\(3\)completely described\&\(4\)/);
}


# now scary stuff... let's try the text_replace() method
# make a few tests...
{
    my $r = undef;
    $r = MKDoc::XML::Tagger::_text_replace ('Hello, World!', 'HeLLo, wOrLd!', 'strong');
    is ($r, '<strong>Hello, World!</strong>');
    
    $r = MKDoc::XML::Tagger::_text_replace ('YO: Hello, World!', 'HeLLo, wOrLd!', 'strong');
    is ($r, 'YO: <strong>Hello, World!</strong>');   

    $r = MKDoc::XML::Tagger::_text_replace ('Hello, World! :OY', 'HeLLo, wOrLd!', 'strong');
    is ($r, '<strong>Hello, World!</strong> :OY');

    $r = MKDoc::XML::Tagger::_text_replace ('YO: Hello, World! :OY', 'HeLLo, wOrLd!', 'strong');
    is ($r, 'YO: <strong>Hello, World!</strong> :OY');
    
    $r = MKDoc::XML::Tagger::_text_replace ('YO: Hello, my &(1)Cool&(2) World! :OY', 'my cool', 'em');
    is ($r, 'YO: Hello, <em>my </em>&(1)<em>Cool</em>&(2) World! :OY');
}


# more nasty test
{
    my $r = MKDoc::XML::Tagger->process_data (
	'Hello Cool World!',
        { _expr => 'Cool World',       _tag => 'a', href => 'cw', alt => 'foo'  },
        { _expr => 'Hello Cool World', _tag => 'a', href => 'hcw' }
       );
    is ($r, '<a href="hcw">Hello Cool World</a>!');

    $r = MKDoc::XML::Tagger->process_data (
	'&lt;hello&gt;',
        { _expr => 'hello', _tag => 'a', href => 'http://www.hello.com/' },
       );
    like ($r, qr/<a/);
}

{
    my $data = qq |<span><p>&lt;p&gt;this is a test, hello world, this is a test&lt;/p&gt;</p></span>|;
    my $r = MKDoc::XML::Tagger->process_data (
        $data,
        { _expr => 'Hello World', _tag => 'a', href => 'cw', alt => 'foo'  }
    );
}


1;


__END__
