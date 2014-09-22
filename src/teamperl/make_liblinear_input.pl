#!/usr/bin/env perl -w

# USAGE
# perl format.pl training_data.csv
# perl format.pl test_data.csv

use strict;
use utf8;

&main();

sub main {
    my $feature_ids = &feature_ids();

    open my $fh, $ARGV[0] or die $!;
    while (<$fh>) {
	next if /^"user_id"/;
	chomp;
	my $features = &extract_feature($_);
	if (/"article_show"/) {
	    printf "-1 ";
	} else {
	    printf "+1 ";
	}
	my @array = ();
	foreach my $key (sort {$feature_ids->{$a} <=> $feature_ids->{$b}} keys %$features) {
	    push @array, sprintf("%d:%d", $feature_ids->{$key}, $features->{$key});
	}
	printf "%s\n", join " ", @array;
    }
}

sub feature_ids {
    my %feature_ids = ();
    my $feature_idx =  0;
    open my $fh, $ARGV[0] or die $!;
    while (<$fh>) {
	next if /^"user_id"/;
	chomp;
	my $features = &extract_feature($_);
	foreach my $feature (keys %$features) {
	    unless ($feature_ids{$feature}) {
		$feature_ids{$feature} = $feature_idx++;
	    }
	}
    }
    close $fh;
    return \%feature_ids;
}

sub extract_feature {
    my ($line) = @_;

    my %features = ();
    my ($user_id, $on_cid, $p_topic_id, $type, $created_at, @words) = split /,/, $line;

    # user feature
    $features{"u$user_id"} = 1;

    # article feature
    $features{"o$on_cid"} = 1;

    # topic feature
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
