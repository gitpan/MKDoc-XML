#!/usr/bin/perl
use lib qw (../lib lib);
use Test::More 'no_plan';
use strict;
use warnings;
use MKDoc::XML::Token;


my $file = (-e 't/data/sample.xml') ? 't/data/sample.xml' : 'data/sample.xml';


my $comment        = new MKDoc::XML::Token ('<!-- this is a comment -->');
my $declaration    = new MKDoc::XML::Token ('<!DECLARATION SOME BIG STOOPID DECLARATION>');
my $pi             = new MKDoc::XML::Token ('<?php 2 + 2?>');
my $open_tag_1     = new MKDoc::XML::Token ('<strong>');
my $open_tag_2     = new MKDoc::XML::Token ('<a href="foo">');
my $close_tag      = new MKDoc::XML::Token ('</strong>');
my $self_close_tag = new MKDoc::XML::Token ('<br />');
my $text           = new MKDoc::XML::Token ('this is some text');


{
    ok !$comment->is_tag_open();
    ok !$comment->is_tag_self_close();
    ok !$comment->is_tag_close();
    ok !$comment->is_pi();
    ok !$comment->is_declaration();
    ok  $comment->is_comment();
    ok !$comment->is_tag();
    ok  $comment->is_pseudotag();
    ok  $comment->is_leaf();
    ok !$comment->is_text();
}


{
    ok !$declaration->is_tag_open();
    ok !$declaration->is_tag_self_close();
    ok !$declaration->is_tag_close();
    ok !$declaration->is_pi();
    ok  $declaration->is_declaration();
    ok !$declaration->is_comment();
    ok !$declaration->is_tag();
    ok  $declaration->is_pseudotag();
    ok  $declaration->is_leaf();
    ok !$declaration->is_text();
}


{
    ok !$pi->is_tag_open();
    ok !$pi->is_tag_self_close();
    ok !$pi->is_tag_close();
    ok  $pi->is_pi();
    ok !$pi->is_declaration();
    ok !$pi->is_comment();
    ok !$pi->is_tag();
    ok  $pi->is_pseudotag();
    ok  $pi->is_leaf();
    ok !$pi->is_text();
}


{
    ok  $open_tag_1->is_tag_open();
    ok !$open_tag_1->is_tag_self_close();
    ok !$open_tag_1->is_tag_close();
    ok !$open_tag_1->is_pi();
    ok !$open_tag_1->is_declaration();
    ok !$open_tag_1->is_comment();
    ok  $open_tag_1->is_tag();
    ok !$open_tag_1->is_pseudotag();
    ok !$open_tag_1->is_leaf();
    ok !$open_tag_1->is_text();
    
    my $n = $open_tag_1->is_tag_open();
    ok ($n->{_open});
    ok (!$n->{_close});
}


{
    ok  $open_tag_2->is_tag_open();
    ok !$open_tag_2->is_tag_self_close();
    ok !$open_tag_2->is_tag_close();
    ok !$open_tag_2->is_pi();
    ok !$open_tag_2->is_declaration();
    ok !$open_tag_2->is_comment();
    ok  $open_tag_2->is_tag();
    ok !$open_tag_2->is_pseudotag();
    ok !$open_tag_2->is_leaf();
    ok !$open_tag_2->is_text();
    my $n = $open_tag_2->is_tag_open();
    ok ($n->{_open});
    ok (!$n->{_close});
}


{
    ok !$close_tag->is_tag_open();
    ok !$close_tag->is_tag_self_close();
    ok  $close_tag->is_tag_close();
    ok !$close_tag->is_pi();
    ok !$close_tag->is_declaration();
    ok !$close_tag->is_comment();
    ok  $close_tag->is_tag();
    ok !$close_tag->is_pseudotag();
    ok !$close_tag->is_leaf();
    ok !$close_tag->is_text();
    my $n = $close_tag->is_tag_close();
    ok (!$n->{_open});
    ok ($n->{_close});
}


{
    ok !$self_close_tag->is_tag_open();
    ok  $self_close_tag->is_tag_self_close();
    ok !$self_close_tag->is_tag_close();
    ok !$self_close_tag->is_pi();
    ok !$self_close_tag->is_declaration();
    ok !$self_close_tag->is_comment();
    ok  $self_close_tag->is_tag();
    ok !$self_close_tag->is_pseudotag();
    ok  $self_close_tag->is_leaf();
    ok !$self_close_tag->is_text();
    my $n = $self_close_tag->is_tag_self_close();
    ok ($n->{_open});
    ok ($n->{_close});
}


{
    ok !$text->is_tag_open();
    ok !$text->is_tag_self_close();
    ok !$text->is_tag_close();
    ok !$text->is_pi();
    ok !$text->is_declaration();
    ok !$text->is_comment();
    ok !$text->is_tag();
    ok !$text->is_pseudotag();
    ok  $text->is_leaf();
    ok  $text->is_text();
}

{
    my $tag = new MKDoc::XML::Token ('<p>');
    my $node = $tag->is_tag();
    is ($node->{_tag}, 'p');
}

1;


__END__
