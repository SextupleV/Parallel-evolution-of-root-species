# HGTdetector.sh

The HGTdetector.sh script was developed to identify Horizontal gene transfer events.

## The pipeline used for identification of HGT-derived genes  
![UB4KWWAO)Q{_F5~73S (ALS](https://github.com/SextupleV/TD-research/assets/22436936/9dea2366-49cc-4074-b627-404270d403e3)

## The usage of HGTdetector.sh script
You can add HGTdetector.sh to your environment and view its usage through the following command.

```HGTdetector.sh -h```

![DQIBV@ RG8OXIH HFK417DD](https://github.com/SextupleV/TD-research/assets/22436936/bb8b3d64-a9c7-4ff7-894e-3f09275a2770)


HGTdetector.sh script requires a total of 5 required input files. The detailed information for creating the blastp database and config files has been described by Koutsovoulos et al. (github.com/GDKO/AvP/wiki)

We provide an example for test, users just need to prepare the blastp database. You can obtain the test files in the example folder and run the HGTdetector.sh script according to the following command:

```HGTdetector.sh -i Arabidopsis_thaliana.pep.fa -d nr.dmnd -c config.yaml -g groups.yaml -m classification.txt```

This script only integrates some programs of AvP software and does not create new ones. If you want to learn more details, you can refer to PMID：36350852.

