cd example
perl ../run_iprscan.pl --cuts 10 --cpu 5 --appl blastprodom --appl fprintscan --appl hmmpfam --appl hmmsmart --appl patternscan --appl profilescan ../../input/test.pep.fa > log 2> log2 &
echo "use interproscanV5"
perl ../run_iprscanV5.pl --cuts 10 --cpu 5 ../../input/test.pep.fa > log 2> log2 &
perl ../run_iprscanV5.pl --cuts 100 --cpu 30 ../../input/genome.all.proteins.fasta > log 2> log2 &
perl ../run_iprscanV5.pl --cuts 100 --cpu 30 ../../input/MSU7.all.pep > log 2> log2 &
perl ../run_iprscanV5.pl --cuts 100 --cpu 30 ../../input/A123_allpathlgv1.maker.proteins.fasta > log 2> log2 &
perl unfinished_jobs.pl --sh A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.sh --cut A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.cut > A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished.sh
perl /rhome/cjinfeng/software/bin/qsub-pbs.pl --maxjob 30 --resource nodes=1:ppn=1,mem=10G,walltime=200:00:00 A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished.sh &
perl unfinished_jobs.pl --sh A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.sh --cut A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.cut > A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished2.sh
perl /rhome/cjinfeng/software/bin/qsub-pbs.pl --maxjob 30 --resource nodes=1:ppn=1,mem=10G,walltime=200:00:00 A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished2.sh
perl unfinished_jobs.pl --sh A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.sh --cut A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.cut > A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished3.sh
perl /rhome/cjinfeng/software/bin/qsub-pbs.pl --maxjob 30 --resource nodes=1:ppn=1,mem=10G,walltime=200:00:00 A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished3.sh
perl unfinished_jobs.pl --sh A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.sh --cut A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.cut > A123_allpathlgv1/A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished4.sh
perl /rhome/cjinfeng/software/bin/qsub-pbs.pl --queue highmem --maxjob 30 --resource nodes=1:ppn=1,mem=30G,walltime=200:00:00 A123_allpathlgv1.maker.proteins.fasta.iprscan.unfinished4.sh

echo "count"
cut -f1 genome.all.proteins.fasta.iprscan | uniq | sort | uniq | wc -l
cut -f1 genome.all.proteins.fasta.iprscan | uniq | sort | uniq > genome.all.proteins.fasta.iprscan.gene
grep -P "\tPfam\t" genome.all.proteins.fasta.iprscan | cut -f 1 | uniq | sort | uniq | wc -l


python ConvertID.py --input HEG4_allpathlgv1/genome.all.proteins.fasta.iprscan --output HEG4.RACA.chr.iprscan
perl iprscan_parser.pl HEG4.RACA.chr.iprscan
cut -f1 HEG4.RACA.chr.iprscan | uniq | sort | uniq > HEG4.RACA.chr.gene
