=head1 NAME

MKDoc::XML - Do XML and XHTML stuff the MKDoc way


=head1 SYNOPSIS

This is an article, not a module.


=head1 SUMMARY

MKDoc is a web content management system written in Perl which focuses on
standards compliance, accessiblity and usability issues, and multi-lingual
websites.

At MKDoc Ltd we have decided to gradually break up our existing commercial
software into a collection of completely independant, well-documented,
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


=head2 An XML tokenizer

L<MKDoc::XML::Tokenizer> will split your XML / XHTML files into a list of
L<MKDoc::XML::Token> objects using a single regex.


=head2 An XML tree builder

L<MKDoc::XML::TreeBuilder> sits on top of L<MKDoc::XML::Tokenizer> and builds
parsed trees out of your XML / XHTML data.


=head2 An XML stripper

L<MKDoc::XML::Stripper> objects will remove unwanted markup from
your XML / HTML data. Useful to remove all those nasty presentational tags
or 'style' attributes from your XHTML data for example.


=head2 An XML tagger

L<MKDoc::XML::Tagger> module will match expressions in XML / XHTML documents
and tag them appropriately. For example, you could automatically hyperlink
certain glossary words or add <abbr> tags based on a dictionary of abbreviations
and acronyms.


=head1 TODO

Rewrite L<MKDoc::XML::Dumper> to use L<MKDoc::XML::TreeBuilder>, write a test
suite (even a small one) for L<MKDoc::XML::Dumper>, and add L<MKDoc::XML::Dumper>
to this distribution.

Write a L<Petal> parser based on L<MKDoc::XML::Tokenizer>. Since Petal is part
of the MKDoc open-source effort, it makes sense for Petal to rely primarily on
MKDoc::XML, especially since MKDoc::XML::* modules are pure perl.

This would bring some extra consistency across MKDoc module distributions
and remove the dependency on XML::Parser.


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

