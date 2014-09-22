#!/usr/bin/env perl -w

# USAGE
# perl add_article_read.pl output submission_data_v2.csv

use strict;
use utf8;

&main();

sub main {
    my @predictions = ();
    open my $fh1, $ARGV[0] or die $!;
    while (<$fh1>) {
	chomp;
	push @predictions, $_;
    }
    close $fh1;

    my $lineno = 0;
    open my $fh2, $ARGV[1] or die $!;
    while (<$fh2>) {
	next if /^"user_id"/;
	chomp;
	if ($predictions[$lineno] == 1) {
	    printf "$_,\"article_read\"\n";
	} else {
	    printf "$_,NULL\n";
	}
	$lineno++;
    }
    close $fh2;
}
