#!/opt/Python/2.7.3/bin/python
import sys
from collections import defaultdict
from numpy import *
import re
import os
import argparse
from Bio import SeqIO 


def usage():
    test="name"
    message='''
python Anno.py --fasta ../input/HEG4_allpathlgv1.maker.proteins.fasta 

    '''
    print message

def fasta_id(fastafile):
    fastaid = defaultdict(str)
    for record in SeqIO.parse(fastafile,"fasta"):
        fastaid[record.id] = 1
    return fastaid

'''
LOC_Os01g01010.1        TBC domain containing protein,expressed
LOC_Os01g01019.1        expressed protein
'''
def tigr7_anno(infile):
    data = defaultdict(str)
    with open (infile, 'r') as filehd:
        for line in filehd:
            line = line.rstrip()
            if len(line) > 2: 
                unit = re.split(r'\t',line)
                data[unit[0]] = unit[1]
    return data

'''
augustus_masked-scaffold_0-processed-gene-0.134-mRNA-1  2       IPR001471; AP2/ERF domain       IPR016177; DNA-binding domain
'''
def iprscan_anno(infile):
    data = defaultdict(str)
    s = re.compile(r'IPR\d+; (.*)')
    with open (infile, 'r') as filehd:
        for line in filehd:
            line = line.rstrip()
            if len(line) > 2: 
                unit = re.split(r'\t',line)
                m = s.search(unit[2])
                if m:
                    data[unit[0]] = m.groups(0)[0]
    return data

'''
maker-scaffold_860-augustus-gene-0.77-mRNA-1    LOC_Os01g25280.1        96.99   133     3       1       8       140     1       132     5e-62    232
'''
def blastm8_anno(infile):
    data = defaultdict(str)
    with open (infile, 'r') as filehd:
        for line in filehd:
            line = line.rstrip()
            if len(line) > 2: 
                unit = re.split(r'\t',line)
                if not data.has_key(unit[0]):
                    data[unit[0]] = unit[1]
    return data


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--fasta')
    parser.add_argument('-o', '--output')
    parser.add_argument('-v', dest='verbose', action='store_true')
    args = parser.parse_args()
    try:
        len(args.fasta) > 0
    except:
        usage()
        sys.exit(2)

    fastaid = fasta_id(args.fasta)
    tigr7   = tigr7_anno('../input/MSU7.gene.anno')
    iprscan = iprscan_anno('../input/genome.all.proteins.fasta.iprscan.gene.ipr')
    blastm8 = blastm8_anno('HEG4_allpathlgv1.maker.proteins.fasta.blastm8')    
    
    for gene in fastaid.keys():
        anno = ''
        if blastm8.has_key(gene):
            anno = tigr7[blastm8[gene]] if tigr7.has_key(blastm8[gene]) else 'hypothetical protein'
        else:
            anno = iprscan[gene] if iprscan.has_key(gene) else 'hypothetical protein'
        print gene + '\t' + anno

if __name__ == '__main__':
    main()

