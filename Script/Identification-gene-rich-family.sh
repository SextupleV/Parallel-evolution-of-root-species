#! /usr/bin/bash

###########

awk 'NR>1&&$2>=10{print $1}' tableS6 > list  # tableS6 can be obtained from Supplementary materials.

for i in  `ls root-plant`
do
    cat root-plant/$i/${i}_gene_family | awk 'NR>1{print $2"\t"$1}' >> all-family
done

if [[ ! -d tmp ]]; then mkdir -p tmp; fi

for i in `cat list`
do
    awk '$1=="'$i'"{print $2}' all-family > tmp/$i
done

for i in `cat list`
do
    for x in `cat list`
    do
        overlap=`awk 'NR==FNR{a[$1]=$0}NR>FNR{if($1 in a)print a[$1]}' tmp/$x tmp/$i | wc -l `
        echo -e $i"\t"$x"\t"$overlap"\t"`awk '{print $0}' tmp/$x | wc -l`"\t"`awk '{print $0}' tmp/$i | wc -l` | awk '{print $1"\t"$2"\t"($3/$4)"\t"$4"\t"$5}' >> tmp/${i}_pro
    done
done

cat tmp/*pro | awk '$3>0.5{print $0}' | awk '{print $0"\t"($4-$5)}' | awk '$6==0||$6>0{print $0}' | awk '{print $1}' > more

cat tmp/*pro | awk '$3>0.5{print $0}' | awk '{print $0"\t"($4-$5)}' | awk '$6<0{print $0}' | awk '{print $2}' > less

cat more less | awk '{a[$1]++;if(a[$1]==1){print $0}}' > more_less

awk 'NR==FNR{a[$1]=$0}NR>FNR{if($1 in a);else print $1}' more_less list >> filitered-list

awk 'NR==FNR{a[$1]=$0}NR>FNR{if($1 in a);else print $1}' less more >> filitered-list

awk '{a[$1]++;if(a[$1]==1){print $0}}' filitered-list > gene-rich-family

rm -r less more filitered-list tmp more_less



