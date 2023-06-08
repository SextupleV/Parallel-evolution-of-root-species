# HGTdetector.sh

The HGTdetector.sh script was developed to identify horizontal gene transfer events.

## The pipeline used for identification of HGT-derived genes  
![FigS21](https://github.com/SextupleV/TD-research/assets/22436936/09ee0c54-8bbd-4371-ab97-6d15241afea3)

## The usage of HGTdetector.sh script

Note: This script only integrates some programs of AvP software and does not create new ones. If you want to learn more details, you can refer to PMID：36350852.

You can add HGTdetector.sh to your environment and view its usage through the following command：

```HGTdetector.sh -h```

![}66L0 W~K6DK7C@ DLN}T0J](https://github.com/SextupleV/TD-research/assets/22436936/13175670-86d7-4f10-a393-dbe38fcdab14)

HGTdetector.sh script requires a total of five input files. The detailed information for creating the blastp database and three config files has been described by Koutsovoulos et al (github.com/GDKO/AvP/wiki).

We provide an example for test, users just need to prepare the blastp database. You can obtain the test files in the example folder and run the HGTdetector.sh script according to the following command:

```HGTdetector.sh -i Arabidopsis_thaliana.pep.fa -d nr.dmnd -c config.yaml -g groups.yaml -m classification.txt```



