#!/usr/bin/env perl
########################################################
# FILE: cutSeq.pl
# USAGE: cutSeq.pl
# DESCRIPTION: 
# OPTIONS: --- 
# REQUIREMENTS: --- 
# BUGS: --- 
# NOTES: --- 
# AUTHOR: Pedro Alexandre F. Galante 
# VERSION: 1.0 
# CREATED: Thu Jun 2 11:38:20 -03 2022 
# REVISION: --- 
# LICENSE: GPL 
########################################################
open (IN0,"<$ARGV[0]");
#
open (OUT0,">new.$ARGV[0]");
$seqLen = $ARGV[1];
while (<IN0>) {
    chomp $_;
    push (@seq1, $_);
}
$lim = $#seq1;
for ($i = 0; $i <= $lim; $i++) {
    $s1 = shift (@seq1);
    if ($s1 =~ /^@/) {
	#print "$s1\n";
	$line1_n = "$s1\n"; #header
	# cut seq
	$s1 = shift (@seq1);
	# seqlen 
	$s1_len = length ($s1);
	#
	$line1_n .= cutseq($s1);
	# header quality
	$s1 = shift (@seq1);
	$line1_n .= "$s1\n"; #header quality                                                                 
	# cut quality
	$s1 = shift (@seq1);
	$line1_n .= cutseq($s1);
	#
	if ($s1_len < $seqLen) {
	    $line1_n = "";
	}
    }
    print OUT0 "$line1_n";
    $line1_n = "";
}
sub cutseq {
    local $seq = $_[0];
    local $seqn = "";
    local $sl = length ($seq);
    if ($sl >= $seqLen) {
	@tmps = split (//, $seq);
	for ($j = 0; $j < $seqLen; $j++) {
	    $seqn .= $tmps[$j];
	}
    }
    $seqn .= "\n";
    return $seqn;
}
