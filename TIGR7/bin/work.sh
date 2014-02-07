perl /rhome/cjinfeng/software/bin/runblastallm8.pl --blastn blastp --infile ../input/HEG4_allpathlgv1.maker.proteins.fasta --database /rhome/cjinfeng/BigData/00.RD/seqlib/GFF/MSU7/MSU7.all.pep
python Anno.py --fasta ../input/HEG4_allpathlgv1.maker.proteins.fasta > HEG4_allpathlgv1.maker.proteins.fasta.anno


