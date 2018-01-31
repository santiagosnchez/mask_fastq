# mask_fastq.py
import gzip
import sys

def qfilt(lseq, lqual, qual_lim):
	"""
        >>> qfilt(['A','G','G','C'], [46,55,39,66], 40)
        >>> 'AGNC'
	"""
	nseq = ''
	nbad = 0
	for (b,q) in zip(lseq, lqual):
		if q < qual_lim:
			if b != 'N':
				nseq += 'N'
				nbad += 1
		else:
			nseq += b
	return nseq, nbad

file = sys.argv[1]
if (len(sys.argv) < 3):
	qual_lim = 50
	print "Quality limit no specified"
	print "Setting quality limit to " + str(qual_lim)
else:
	qual_lim = int(sys.argv[2])
	print "Setting quality limit to " + str(qual_lim)

nbad = 0
seqn = 0
outf = "masked_"+file.split("/")[-1]
print "Writing to: " + outf
with gzip.open(outf,'wb') as fq_out:
	with gzip.open(file,'rb') as fq_in:
		for num, line in enumerate(fq_in,1):
			if num % 4 == 1:
				fq_out.write(line)
			elif num % 4 == 2:
				seq = line.rstrip()
			elif num % 4 == 0:
				qual = map(lambda x: ord(x), list(line.rstrip()))
				new = qfilt(list(seq), qual, qual_lim)
				fq_out.write(new[0]+"\n+\n")
				fq_out.write(line)
				seqn += 1
				nbad += new[1]
				sys.stdout.write("Seqs read: " + str(seqn) + "\r"),
				sys.stdout.flush()

print "\nTotal number changed bases: " + str(nbad)
