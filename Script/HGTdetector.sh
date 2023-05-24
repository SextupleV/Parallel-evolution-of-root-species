#!/bin/bash

############################################

func() {
    echo "
 Usage:
          HGTdetect [-i inputfile] [-c config.yaml] [-g groups.yaml] [-m classification] [-d database] [...]
"
    echo " Options:
 ---------------------
  Required parameter:
 ---------------------
          -i <FILE>  fasta sequence of target species
          -d <FILE>  Diamond database path
          -c <FILE>  config.yaml (config file)
          -g <FILE>  groups.yaml (config file)
          -m <FILE>  classification.txt (config file)
 ---------------------
  Optional parameter:
 ---------------------
          -o <DIR>   creates a directory for output files (default: Avp_out)
          -k <INT>   maximum number of target sequences to report alignments for (default: 1000)
          -e <NUM>   blast E-value (default: 1e-10)
          -n <INT>   mix gene number of one group from donors (default: 30)
          -h         show this
"
}

#########

input=""
config=""
groups=""
classification=""
database=""
output=Avp_out
donor_n=30
hits=1000
evalue=1e-10
########

########
while getopts 'i:c:g:m:x:o:d:n:k:e:h' OPT; do
    case $OPT in
        i) input=$OPTARG;;
        c) config=$OPTARG;;
        g) groups=$OPTARG;;
        m) classification=$OPTARG;;
        o) output=$OPTARG;;
        d) database=$OPTARG;;
        n) donor_n=$OPTARG;;
        k) hits=$OPTARG;;
        e) evalue=$OPTARG;;
        *) func
           exit 1;;
    esac
done
########

if [ -z $input ] || [ -z $config ] || [ -z $groups ] || [ -z $classification ] || [ -z $database ];then

  func

else
   if [[ ! -d $output ]]; then mkdir -p $output; fi

  diamond blastp -q $input -d $database --evalue $evalue --max-target-seqs $hits --out $output/${input}.avp_blast.out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids

  calculate_ai.py -i $output/${input}.avp_blast.out -x $groups

  avp prepare -a $output/${input}.avp_blast.out_ai.out -o $output/avp_out -f $input -b $output/${input}.avp_blast.out -x $groups -c $config

  echo -e group"\t"donor_number > $output/avp_out/donor_number
  for i in `ls $output/avp_out/fastagroups`; do echo -e $i"\t"`grep ">" $output/avp_out/fastagroups/$i | grep -v -E 'StudiedOrganism|EGP|Ingroup' | wc -l` >>$output/avp_out/donor_number;done

  awk '$3>='$donor_n'{print $0}' $output/avp_out/donor_number >$output/avp_out/filiter_donor_number

  awk 'NR==FNR{a[$1]=$0}NR>FNR{if($1 in a)print $0}' $output/avp_out/filiter_donor_number $output/avp_out/groups.tsv >$output/avp_out/filiter_groups.tsv

  avp detect -i $output/avp_out/mafftgroups/ -o $output/avp_out/ -g $output/avp_out/filiter_groups.tsv -t $output/avp_out/tmp/taxonomy_nexus.txt -c $config

  avp classify -i $output/avp_out/fasttree_nexus/ -o $output/avp_out/ -t $output/avp_out/fasttree_tree_results.txt -f $classification -c $config
  rm $output/avp_out/filiter_groups.tsv $output/avp_out/filiter_donor_number
fi

############################################




