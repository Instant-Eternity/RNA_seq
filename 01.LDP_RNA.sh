##########################################################################
# File Name: 01.fastqc.sh
# Author: Xianglong Zhang
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Thu 25 Mar 2021 09:28:47 AM CST
#########################################################################
#!/use/bin/bash
time fastqc -o /bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/01_FastQC -f fastq /bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/01_ABX/*.fq.gz

time fastqc -o /bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/01_FastQC -f fastq /bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/02_Ctrl/*.fq.gz

##########################################################################
# File Name: 02.multiqc.sh
# Author: Xianglong Zhang
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 10:06:21 AM CST
#########################################################################
#!/use/bin/bash
fastqc=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/01_FastQC
result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/02_multiqc
time multiqc $fastqc/*_fastqc.zip -o $result

##########################################################################
# File Name: 03.hisat2.sh
# Author: Xianglong Zhang
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Sun 28 Mar 2021 09:54:06 PM CST
#########################################################################
#!/use/bin/bash
#ref_data=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/04_ref_mm39
#time extract_exons.py $ref_data/gencode.vM27.chr_patch_hapl_scaff.annotation.gtf > $ref_data/mm39.exons.gtf &
#time extract_splice_sites.py $ref_data/gencode.vM27.chr_patch_hapl_scaff.annotation.gtf > $ref_data/mm39.splice_sites.gtf &
#time hisat2-build --ss $ref_data/mm39.splice_sites.gtf --exon $ref_data/mm39.exons.gtf $ref_data/mm39.fa mm39

#ref=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/mm10/genome
ref=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/04_ref_mm39/mm39/mm39
data_ABX=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/01_ABX
data_Ctrl=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/02_Ctrl
result=/bigdata/wangzhang_guest/chenpeng_project/06_result/07_LDP_RNAseq/03_Hisat2
#result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/03_Hisat2

time hisat2 --dta -t -x $ref -1 $data_ABX/clp-abx-1_FRAS210074515-1r_1.clean.fq.gz -2 $data_ABX/clp-abx-1_FRAS210074515-1r_2.clean.fq.gz -S $result/ABX-1.sam
time hisat2 --dta -t -x $ref -1 $data_ABX/clp-abx-2_FRAS210074516-1r_1.clean.fq.gz -2 $data_ABX/clp-abx-2_FRAS210074516-1r_2.clean.fq.gz -S $result/ABX-2.sam
time hisat2 --dta -t -x $ref -1 $data_ABX/clp-abx-3_FRAS210074517-1r_1.clean.fq.gz -2 $data_ABX/clp-abx-3_FRAS210074517-1r_2.clean.fq.gz -S $result/ABX-3.sam
time hisat2 --dta -t -x $ref -1 $data_ABX/clp-abx-4_FRAS210074518-1r_1.clean.fq.gz -2 $data_ABX/clp-abx-4_FRAS210074518-1r_2.clean.fq.gz -S $result/ABX-4.sam
time hisat2 --dta -t -x $ref -1 $data_ABX/clp-abx-5_FRAS210074519-1r_1.clean.fq.gz -2 $data_ABX/clp-abx-5_FRAS210074519-1r_2.clean.fq.gz -S $result/ABX-5.sam

time hisat2 --dta -t -x $ref -1 $data_Ctrl/clp-ctrl-1_FRAS210074510-1r_1.clean.fq.gz -2 $data_Ctrl/clp-ctrl-1_FRAS210074510-1r_2.clean.fq.gz -S $result/Ctrl-1.sam
time hisat2 --dta -t -x $ref -1 $data_Ctrl/clp-ctrl-2_FRAS210074511-1r_1.clean.fq.gz -2 $data_Ctrl/clp-ctrl-2_FRAS210074511-1r_2.clean.fq.gz -S $result/Ctrl-2.sam
time hisat2 --dta -t -x $ref -1 $data_Ctrl/clp-ctrl-3_FRAS210074512-1r_1.clean.fq.gz -2 $data_Ctrl/clp-ctrl-3_FRAS210074512-1r_2.clean.fq.gz -S $result/Ctrl-3.sam
time hisat2 --dta -t -x $ref -1 $data_Ctrl/clp-ctrl-4_FRAS210074513-1r_1.clean.fq.gz -2 $data_Ctrl/clp-ctrl-4_FRAS210074513-1r_2.clean.fq.gz -S $result/Ctrl-4.sam
time hisat2 --dta -t -x $ref -1 $data_Ctrl/clp-ctrl-5_FRAS210074514-1r_1.clean.fq.gz -2 $data_Ctrl/clp-ctrl-5_FRAS210074514-1r_2.clean.fq.gz -S $result/Ctrl-5.sam

result=/bigdata/wangzhang_guest/chenpeng_project/06_result/07_LDP_RNAseq
mkdir $result/04_sam_to_bam
hisat2_result=/bigdata/wangzhang_guest/chenpeng_project/06_result/07_LDP_RNAseq/03_Hisat2
sam_bam=/bigdata/wangzhang_guest/chenpeng_project/06_result/07_LDP_RNAseq/04_sam_to_bam

time samtools view -bS $hisat2_result/ABX-1.sam > $sam_bam/ABX-1.bam
time samtools view -bS $hisat2_result/ABX-2.sam > $sam_bam/ABX-2.bam
time samtools view -bS $hisat2_result/ABX-3.sam > $sam_bam/ABX-3.bam
time samtools view -bS $hisat2_result/ABX-4.sam > $sam_bam/ABX-4.bam
time samtools view -bS $hisat2_result/ABX-5.sam > $sam_bam/ABX-5.bam

time samtools view -bS $hisat2_result/Ctrl-1.sam > $sam_bam/Ctrl-1.bam
time samtools view -bS $hisat2_result/Ctrl-2.sam > $sam_bam/Ctrl-2.bam
time samtools view -bS $hisat2_result/Ctrl-3.sam > $sam_bam/Ctrl-3.bam
time samtools view -bS $hisat2_result/Ctrl-4.sam > $sam_bam/Ctrl-4.bam
time samtools view -bS $hisat2_result/Ctrl-5.sam > $sam_bam/Ctrl-5.bam

time samtools sort $sam_bam/ABX-1.bam -o $sam_bam/Sorted-ABX-1.bam
time samtools sort $sam_bam/ABX-2.bam -o $sam_bam/Sorted-ABX-2.bam
time samtools sort $sam_bam/ABX-3.bam -o $sam_bam/Sorted-ABX-3.bam
time samtools sort $sam_bam/ABX-4.bam -o $sam_bam/Sorted-ABX-4.bam
time samtools sort $sam_bam/ABX-5.bam -o $sam_bam/Sorted-ABX-5.bam

time samtools sort $sam_bam/Ctrl-1.bam -o $sam_bam/Sorted-Ctrl-1.bam
time samtools sort $sam_bam/Ctrl-2.bam -o $sam_bam/Sorted-Ctrl-2.bam
time samtools sort $sam_bam/Ctrl-3.bam -o $sam_bam/Sorted-Ctrl-3.bam
time samtools sort $sam_bam/Ctrl-4.bam -o $sam_bam/Sorted-Ctrl-4.bam
time samtools sort $sam_bam/Ctrl-5.bam -o $sam_bam/Sorted-Ctrl-5.bam

time samtools sort -n $sam_bam/ABX-1.bam > $sam_bam/Name-Sorted-ABX-1.bam
time samtools sort -n $sam_bam/ABX-2.bam > $sam_bam/Name-Sorted-ABX-2.bam
time samtools sort -n $sam_bam/ABX-3.bam > $sam_bam/Name-Sorted-ABX-3.bam
time samtools sort -n $sam_bam/ABX-4.bam > $sam_bam/Name-Sorted-ABX-4.bam
time samtools sort -n $sam_bam/ABX-5.bam > $sam_bam/Name-Sorted-ABX-5.bam

time samtools sort -n $sam_bam/Ctrl-1.bam > $sam_bam/Name-Sorted-Ctrl-1.bam
time samtools sort -n $sam_bam/Ctrl-2.bam > $sam_bam/Name-Sorted-Ctrl-2.bam
time samtools sort -n $sam_bam/Ctrl-3.bam > $sam_bam/Name-Sorted-Ctrl-3.bam
time samtools sort -n $sam_bam/Ctrl-4.bam > $sam_bam/Name-Sorted-Ctrl-4.bam
time samtools sort -n $sam_bam/Ctrl-5.bam > $sam_bam/Name-Sorted-Ctrl-5.bam
#rm $hisat2_result/ABX-*.sam

#rm $hisat2_result/Ctrl-*.sam

#rm $sam_bam/ABX-*.bam

#rm $sam_bam/Ctrl-*.bam

time samtools index $sam_bam/Sorted-ABX-1.bam
time samtools index $sam_bam/Sorted-ABX-2.bam
time samtools index $sam_bam/Sorted-ABX-3.bam
time samtools index $sam_bam/Sorted-ABX-4.bam
time samtools index $sam_bam/Sorted-ABX-5.bam

time samtools index $sam_bam/Sorted-Ctrl-1.bam
time samtools index $sam_bam/Sorted-Ctrl-2.bam
time samtools index $sam_bam/Sorted-Ctrl-3.bam
time samtools index $sam_bam/Sorted-Ctrl-4.bam
time samtools index $sam_bam/Sorted-Ctrl-5.bam

#time samtools index $sam_bam/Name-Sorted-ABX-1.bam
#time samtools index $sam_bam/Name-Sorted-ABX-2.bam
#time samtools index $sam_bam/Name-Sorted-ABX-3.bam
#time samtools index $sam_bam/Name-Sorted-ABX-4.bam
#time samtools index $sam_bam/Name-Sorted-ABX-5.bam

#time samtools index $sam_bam/Name-Sorted-Ctrl-1.bam
#time samtools index $sam_bam/Name-Sorted-Ctrl-2.bam
#time samtools index $sam_bam/Name-Sorted-Ctrl-3.bam
#time samtools index $sam_bam/Name-Sorted-Ctrl-4.bam
#time samtools index $sam_bam/Name-Sorted-Ctrl-5.bam

##########################################################################
# File Name: 04.samtools.sh
# Author: Xianglong Zhang
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 10:15:45 AM CST
#########################################################################
#!/use/bin/bash
#time samtools view -bS abc.sam > abc.bam
#time samtools view -b -S abc.sam -o abc.bam
result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq
mkdir $result/04_sam_to_bam
hisat2_result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/03_Hisat2
sam_bam=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/04_sam_to_bam
'''
time samtools view -bS $hisat2_result/ABX-1.sam > $sam_bam/ABX-1.bam
time samtools view -bS $hisat2_result/ABX-2.sam > $sam_bam/ABX-2.bam
time samtools view -bS $hisat2_result/ABX-3.sam > $sam_bam/ABX-3.bam
time samtools view -bS $hisat2_result/ABX-4.sam > $sam_bam/ABX-4.bam
time samtools view -bS $hisat2_result/ABX-5.sam > $sam_bam/ABX-5.bam

time samtools view -bS $hisat2_result/Ctrl-1.sam > $sam_bam/Ctrl-1.bam
time samtools view -bS $hisat2_result/Ctrl-2.sam > $sam_bam/Ctrl-2.bam
time samtools view -bS $hisat2_result/Ctrl-3.sam > $sam_bam/Ctrl-3.bam
time samtools view -bS $hisat2_result/Ctrl-4.sam > $sam_bam/Ctrl-4.bam
time samtools view -bS $hisat2_result/Ctrl-5.sam > $sam_bam/Ctrl-5.bam

time samtools sort $sam_bam/ABX-1.bam -o $sam_bam/Sorted-ABX-1.bam
time samtools sort $sam_bam/ABX-2.bam -o $sam_bam/Sorted-ABX-2.bam
time samtools sort $sam_bam/ABX-3.bam -o $sam_bam/Sorted-ABX-3.bam
time samtools sort $sam_bam/ABX-4.bam -o $sam_bam/Sorted-ABX-4.bam
time samtools sort $sam_bam/ABX-5.bam -o $sam_bam/Sorted-ABX-5.bam

time samtools sort $sam_bam/Ctrl-1.bam -o $sam_bam/Sorted-Ctrl-1.bam
time samtools sort $sam_bam/Ctrl-2.bam -o $sam_bam/Sorted-Ctrl-2.bam
time samtools sort $sam_bam/Ctrl-3.bam -o $sam_bam/Sorted-Ctrl-3.bam
time samtools sort $sam_bam/Ctrl-4.bam -o $sam_bam/Sorted-Ctrl-4.bam
time samtools sort $sam_bam/Ctrl-5.bam -o $sam_bam/Sorted-Ctrl-5.bam

rm $hisat2_result/ABX-*.sam

rm $hisat2_result/Ctrl-*.sam

rm $sam_bam/ABX-*.bam

rm $sam_bam/Ctrl-*.bam
'''
time samtools index $sam_bam/Sorted-ABX-1.bam
time samtools index $sam_bam/Sorted-ABX-2.bam
time samtools index $sam_bam/Sorted-ABX-3.bam
time samtools index $sam_bam/Sorted-ABX-4.bam
time samtools index $sam_bam/Sorted-ABX-5.bam

time samtools index $sam_bam/Sorted-Ctrl-1.bam
time samtools index $sam_bam/Sorted-Ctrl-2.bam
time samtools index $sam_bam/Sorted-Ctrl-3.bam
time samtools index $sam_bam/Sorted-Ctrl-4.bam
time samtools index $sam_bam/Sorted-Ctrl-5.bam

##########################################################################
# File Name: 05.STAR.sh
# Author: Xianglong Zhang
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 09:31:56 PM CST
#########################################################################
#!/use/bin/bash
'''
time STAR --runThreadN 6 \
          --runMode genomeGenerate \
          --genomeDir /bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/mm10/ \
          --genomeFastaFiles /bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/mm.fa \
          --sjdbGTFfile /bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/gencode.vM26.annotation.gtf \
          --sjdbOverhang 100
'''
ref=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/mm10/
data_ABX=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/01_ABX
data_Ctrl=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/02_Ctrl
result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/04_STAR

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_ABX/clp-abx-1_FRAS210074515-1r_1.clean.fq.gz $data_ABX/clp-abx-1_FRAS210074515-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/ABX-1

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_ABX/clp-abx-2_FRAS210074516-1r_1.clean.fq.gz $data_ABX/clp-abx-2_FRAS210074516-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/ABX-2

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_ABX/clp-abx-3_FRAS210074517-1r_1.clean.fq.gz $data_ABX/clp-abx-3_FRAS210074517-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/ABX-3

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_ABX/clp-abx-4_FRAS210074518-1r_1.clean.fq.gz $data_ABX/clp-abx-4_FRAS210074518-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/ABX-4

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_ABX/clp-abx-5_FRAS210074519-1r_1.clean.fq.gz $data_ABX/clp-abx-5_FRAS210074519-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/ABX-5

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_Ctrl/clp-ctrl-1_FRAS210074510-1r_1.clean.fq.gz $data_Ctrl/clp-ctrl-1_FRAS210074510-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/Ctrl-1

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_Ctrl/clp-ctrl-2_FRAS210074511-1r_1.clean.fq.gz $data_Ctrl/clp-ctrl-2_FRAS210074511-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/Ctrl-2

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_Ctrl/clp-ctrl-3_FRAS210074512-1r_1.clean.fq.gz $data_Ctrl/clp-ctrl-3_FRAS210074512-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/Ctrl-3

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_Ctrl/clp-ctrl-4_FRAS210074513-1r_1.clean.fq.gz $data_Ctrl/clp-ctrl-4_FRAS210074513-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/Ctrl-4

time STAR --runThreadN 20 --genomeDir $ref --readFilesCommand gunzip -c --readFilesIn $data_Ctrl/clp-ctrl-5_FRAS210074514-1r_1.clean.fq.gz $data_Ctrl/clp-ctrl-5_FRAS210074514-1r_2.clean.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $result/Ctrl-5


