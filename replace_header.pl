#!/usr/bin/perl

use strict;
use warnings;

# open the first fasta file
open(my $fh1, "<", $ARGV[0]) or die "Cannot open file $ARGV[0]: $!";

# open the second fasta file
open(my $fh2, "<", $ARGV[1]) or die "Cannot open file $ARGV[1]: $!";

# read the first fasta file into a hash
my %fasta1;
my $header1;
while (my $line = <$fh1>) {
    chomp $line;
    if ($line =~ /^>/) {
	my $annotation;
        ($header1, $annotation) = (split /\s+/, $line, 2);
        $fasta1{$header1} = $annotation;
    }
}

# read the second fasta file into a hash
my %fasta2;
my $header2;
while (my $line = <$fh2>) {
    chomp $line;
    if ($line =~ /^>/) {
	    $header2 = $line;
	    $header2 =~ s/_CDS.*//;
	    $header2 =~ s/.mrna.*//;
	    $line .= " $fasta1{$header2}" if exists $fasta1{$header2};
	print "$line\n";
    } else {
    print "$line\n";
    }
}

# close the files
close $fh1;
close $fh2;

