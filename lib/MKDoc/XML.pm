=head1 NAME

MKDoc::XML - The MKDoc XML Toolkit


=head1 SYNOPSIS

This is an article, not a module.


=head1 SUMMARY

MKDoc is a web content management system written in Perl which focuses on
standards compliance, accessiblity and usability issues, and multi-lingual
websites.

At MKDoc Ltd we have decided to gradually break up our existing commercial
software into a collection of completely independent, well-documented,
well-tested open-source CPAN modules.

Ultimately we want MKDoc code to be a coherent collection of module
distributions, yet each distribution should be usable and useful in itself.

MKDoc::XML is part of this effort.

You could help us and turn some of MKDoc's code into a CPAN module.
You can take a look at the existing code at http://download.mkdoc.org/.

If you are interested in some functionality which you would like to
see as a standalone CPAN module, send an email to
<mkdoc-modules@lists.webarch.co.uk>.


=head1 WHAT'S IN THE BOX


=head2 XML tokenizer

L<MKDoc::XML::Tokenizer> splits your XML / XHTML files into a list of
L<MKDoc::XML::Token> objects using a single regex.


=head2 XML tree builder

L<MKDoc::XML::TreeBuilder> sits on top of L<MKDoc::XML::Tokenizer> and builds
parsed trees out of your XML / XHTML data.


=head2 XML stripper

L<MKDoc::XML::Stripper> objects removes unwanted markup from
your XML / HTML data. Useful to remove all those nasty presentational tags
or 'style' attributes from your XHTML data for example.


=head2 XML tagger

L<MKDoc::XML::Tagger> module matches expressions in XML / XHTML documents
and tag them appropriately. For example, you could automatically hyperlink
certain glossary words or add <abbr> tags based on a dictionary of abbreviations
and acronyms.


=head2 HTML entity decoder

L<MKDoc::XML::DecodeHO> decodes HTML entities only, leaving &apos; &quot; &gt;
&lt; and &amp; untouched.


=head2 XML entity decoder

L<MKDoc::XML::Decode> decodes &apos; &quot; &gt; &lt; and &amp; only, leaving
any other entity untouched.


=head2 XML entity encoder

L<MKDoc::XML::Encode> does the exact reverse operation as L<MKDoc::XML::Decode>.


=head2 XML Dumper

L<MKDoc::XML::Dumper> serializes arbitrarily complex perl structures into XML strings.
It is also able of doing the reverse operation, i.e. deserializing an XML string into
a perl structure.


=head1 TODO

Write a L<Petal> parser based on L<MKDoc::XML::Tokenizer>. Since Petal is part
of the MKDoc open-source effort, it makes sense for Petal to rely primarily on
MKDoc::XML, especially since MKDoc::XML::* modules are pure perl.

This would bring some extra consistency across MKDoc module distributions
and remove the Petal dependency on XML::Parser.


=head1 AUTHOR

Copyright 2003 - MKDoc Holdings Ltd.

Author: Jean-Michel Hiver <jhiver@mkdoc.com>

This module is free software and is distributed under the same license as Perl
itself. Use it at your own risk.


=head1 SEE ALSO

  Petal: http://search.cpan.org/author/JHIVER/Petal/
  MKDoc: http://www.mkdoc.com/

Help us open-source MKDoc. Join the mkdoc-modules mailing list:

  mkdoc-modules@lists.webarch.co.uk

=cut

