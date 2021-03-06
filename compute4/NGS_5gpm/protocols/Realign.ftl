#
# =====================================================
# $Id$
# $URL$
# $LastChangedDate$
# $LastChangedRevision$
# $LastChangedBy$
# =====================================================
#

#MOLGENIS walltime=35:59:00 mem=10 cores=1

module load GATK/${gatkVersion}
module list

inputs "${dedupbam}" 
inputs "${indexfile}" 
inputs "${dbsnprod}"
inputs "${pilot1KgVcf}"
inputs "${realignTargets}"
alloutputsexist "${realignedbam}"

java -Djava.io.tmpdir=${tempdir} -Xmx10g -jar \
${genomeAnalysisTKjar} \
-l INFO \
-T IndelRealigner \
-U ALLOW_UNINDEXED_BAM \
-I ${dedupbam} \
--out ${realignedbam} \
-targetIntervals ${realignTargets} \
-R ${indexfile} \
-D ${dbsnprod} \
-B:indels,VCF ${pilot1KgVcf} \
-knownsOnly \
-LOD 0.4 \
-maxReads 2000000