#!/usr/bin/env perl -w

# USAGE
# perl make_liblinear_format.pl training_data.csv
# perl make_liblinear_format.pl test_data.csv

use strict;
use utf8;

&main();

sub main {
    my %feature_ids = ();
    my $id = 0;
    open my $fh, $ARGV[0] or die $!;
    while (<$fh>) {
	next if /^"user_id"/;
	chomp;
	my $features = &extract_feature($_);

	# add new features to %feature_ids
	foreach my $feature (keys %$features) {
	    $feature_ids{$feature} = $id++ unless $feature_ids{$feature};
	}
    }
    close $fh;

    open $fh, $ARGV[0] or die $!;
    while (<$fh>) {
	next if /^"user_id"/;
	chomp;
	my $features = &extract_feature($_);

	# print a liblinear example for a given line
	if (/"article_show"/) {
	    printf "-1 ";
	} else {
	    printf "+1 ";
	}
	my @temp = ();
	foreach my $feature (sort {$feature_ids{$a} <=> $feature_ids{$b}} keys %$features) {
	    push @temp, sprintf("%d:%d", $feature_ids{$feature}, $features->{$feature});
	}
	printf "%s\n", join " ", @temp;
    }
}

sub extract_feature {
    my ($line) = @_;

    my %features = ();
    my ($user_id, $on_cid, $p_topic_id, $type, $created_at, @words) = split /,/, $line;

    $features{"u$user_id"}    = 1;
    $features{"o$on_cid"}     = 1;
    $features{"p$p_topic_id"} = 1;

    # time features
    my ($date, $time) = split / /, $created_at;
    $date =~ s/^"//;
    $time =~ s/"$//;
    $features{"d$date"} = 1;
    $features{"t$time"} = 1;

    # word features
    foreach my $word (@words) {
	$features{"w$word"}++;
    }

    return \%features;
}
