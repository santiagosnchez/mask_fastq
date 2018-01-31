# mask_fastq

There is a Perl and Python version which esentially do the same.

# mask_fastq.pl

Perl script that masks bases as "N"s given a PHRED quality threshold.

The program is loosely based on [SubN](https://code.google.com/archive/p/subn/) published by [Yun and Yun (2014)](#references). The main difference is that `mask_fastq.pl` can natively handle I/O compressed (gzipped) files and does not depend on any external modules.

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

# mask_fastq.py

## Download

    wget https://raw.githubusercontent.com/santiagosnchez/mask_fastq/master/mask_fastq.py

## Running the code

    
    python mask_fastq.py my_fastq_file.fq.gz 55
    
The number at the end is the Phred quality score limit. By default it will be 50 (e.g. if not provided).

# References

Yun, Sajung, & Yun, S. (2014). Masking as an effective quality control method for next-generation sequencing data analysis. BMC Bioinformatics, 15(1), 152–8. http://doi.org/10.1186/s12859-014-0382-2
