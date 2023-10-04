##########################################################################
# File Name: 03.STAR.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 09:31:56 PM CST
#########################################################################
#!/use/bin/bash
ref=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/00_ref/mm10/
data_ABX=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/01_ABX
data_Ctrl=/bigdata/wangzhang_guest/chenpeng_project/01_data/07_LDP_clean_data_rnaseq/02_Ctrl
result=/bigdata/wangzhang_guest/chenpeng_project/06_result/06_LDP_RNAseq/04_STAR

time STAR --runThreadN 20 \
	--genomeDir $ref \
 	--readFilesCommand gunzip \
  	-c --readFilesIn $data_ABX/clp-abx-1_FRAS210074515-1r_1.clean.fq.gz $data_ABX/clp-abx-1_FRAS210074515-1r_2.clean.fq.gz \
	--outSAMtype BAM SortedByCoordinate \
 	--outFileNamePrefix $result/ABX-1
