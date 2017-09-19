# mask_fastq.pl
Perl script that masks bases as "N"s given a PHRED quality threshold.

The program is loosely based on [SubN](https://code.google.com/archive/p/subn/) published by [Yun and Yun (2014)](#references). The main difference is that `mask_fastq.pl` can natively I/O compressed (gzipped) files and does not depend on any external modules.

## Installation

    git clone https://github.com/santiagosnchez/mask_fastq
    cd mask_fastq
    chmod +x mask_fastq.pl
    sudo cp mask_fastq.pl /usr/local/bin

## Running the code

Use the `-h` flag for more details:

    perl mask_fastq.pl -h
    
    #########################
    # Running mask_fastq.pl #
    #########################
    
    Try:
    
    perl mask_fastq.pl -f myseqs.fastq(.gz) [ -q PHRED_VALUE ]
    
