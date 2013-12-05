cd example
perl ../run_iprscan.pl --cuts 10 --cpu 5 --appl blastprodom --appl fprintscan --appl hmmpfam --appl hmmsmart --appl patternscan --appl profilescan ../../input/test.pep.fa > log 2> log2 &
echo "use interproscanV5"
perl ../run_iprscanV5.pl --cuts 10 --cpu 5 ../../input/test.pep.fa > log 2> log2 &
perl ../run_iprscanV5.pl --cuts 100 --cpu 30 ../../input/genome.all.proteins.fasta > log 2> log2 &
