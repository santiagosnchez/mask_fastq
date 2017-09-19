#!/usr/bin/perl
# ©Santiago Sanchez-Ramirez
# see: https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-014-0382-2
# based on SubN_v_0.0.4.pl

print "\n#########################\n# Running mask_fastq.pl #\n#########################\n\n";

my $usage = "Try:\n\nperl mask_fastq.pl -f myseqs.fastq(.gz) [ -q PHRED_VALUE ]\n";

my $file;
my $gzip = 0;
my $qval = 50;
my $out;

# help commands and inital variables

if (grep { /^-*he{0,1}l{0,1}p{0,1}$/i } @ARGV){
	die $usage;
} else {
	if (my ($ind) = grep { $ARGV[$_] =~ /^-f$/i } 0 .. $#ARGV){
		$file = $ARGV[$ind+1];
		if ($file =~ m/\.gz$/){
			$gzip = 1;
			$out = $file;
			$out =~ s/\.fa{0,1}s{0,1}t{0,1}q\.gz/_masked\.fastq\.gz/i;
			print "File: $file is gzipped. Output will be gzipped too: $out\n";
		} else {
			$out =~ s/\.fa{0,1}s{0,1}t{0,1}q/_masked\.fastq/i;
		}
	} else {
		die $usage;
	}
	if (my ($ind) = grep { $ARGV[$_] =~ /^-q$/i } 0 .. $#ARGV){
		$qval = $ARGV[$ind+1];
		print "Using provided PHRED score value: $qval\n";
	} else {
		print "Using default PHRED score value: $qval\n";
	}
}

# open fastq file and output

if ($gzip == 1){
    open(FQ,"-|"," gunzip < $file") or die "Cannot open $file\n";
    open(OU,"|-"," gzip > $out") or die "Cannot open $out\n";
} else {
    open(FQ,"<",$file) or die "Cannot open $file\n";
    open(OU,">",$out) or die "Cannot open $out\n";
}

# read and process fastq file

my $count=0;
local $| = 1;
while (<FQ>){
	my $ind =  $. % 4;
	if ($ind == 1){
		$head = $_;
	} elsif ($ind == 2){
		++$count;
		print "Processing sequence:   $count        \r";
		chomp $_;
		@seq = split //, $_;
	} elsif ($ind == 0){
		chomp $_;
		@qual = unpack "C*", $_; # unpack ASCII codes into a list of PHRED scores
		@low = grep { $qual[$_] < $qval } 0 .. $#qual; # get the indices of low quality bases
		map { splice @seq, $_, 1, "N"; } @low; # substitute low quality bases for N's
		# Print output
		print OU $head;
		print OU join('',@seq) . "\n+\n";
		print OU "$_\n"; 
	}
}
close FQ;
close OU;
local $| = 0;
print "\ndone.\n\n";





