#!/usr/bin/perl
use lib qw (../lib lib);
use Test::More 'no_plan';
use strict;
use warnings;
use MKDoc::XML::Stripper;


{    
    my $stripper = new MKDoc::XML::Stripper;
    $stripper->load_def ('mkdoc16');

    # check that a few values are really there
    ok ($stripper->{tr}->{'lang'});
    ok ($stripper->{tr}->{'align'});
    ok ($stripper->{tr}->{'valign'});
    ok ($stripper->{tr}->{'char'});
    ok ($stripper->{tr}->{'title'});
    ok ($stripper->{tr}->{'id'});
    ok ($stripper->{tr}->{'class'});
    ok ($stripper->{tr}->{'xml:lang'});
    ok ($stripper->{tr}->{'charoff'});
    ok ($stripper->{tr}->{'dir'});
}


1;


__END__
