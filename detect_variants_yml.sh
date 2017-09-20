#!/bin/bash

OPTS=`getopt -o r:t:n:i:d:c:m:p:v:s: --long reference:,tumor:,normal:,intervals:,dbsnp:,cosmic:,docm:,pon:,vepcache:,synonyms: -n 'parse-options' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

#echo "$OPTS"
eval set -- "$OPTS"

REF=""
TUMOR=""
NORMAL=""
INTERVALS=""
DBSNP=""
COSMIC=""
DOCM=""
PON=""
VEPCACHE=""
SYNONYMS=""

while true; do
  case "$1" in
    -r | --reference ) REF="$2"; shift ;;
    -t | --tumor )    TUMOR="$2"; shift ;;
    -n | --normal ) NORMAL="$2"; shift ;;
    -i | --intervals ) ="$2"; shift; shift ;;
    -d | --dbsnp ) DBSNP="$2"; shift; shift ;;
    -c | --cosmic ) COSMIC="$2"; shift; shift ;;
    -m | --docm ) DOCM="$2"; shift; shift ;;     
    -p | --pon ) PON="$2"; shift; shift ;;     
    -v | --vepcache ) VEPCACHE="$2"; shift; shift ;;
    -s | --synonyms ) SYNONYMS="$2"; shift; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

cat <<EOF
reference: $REF
tumor_cram:
  class: File
  path: $TUMOR
normal_cram:
  class: File
  path: $NORMAL
interval_list:
  class: File
  path: $INTERVALS
dbsnp_vcf:
  class: File
  path: $DBSNP
cosmic_vcf:
  class: File
  path: $COSMIC
panel_of_normals_vcf:
  class: File
  path: $PON
strelka_exome_mode: true
mutect_scatter_count: 50
mutect_artifact_detection_mode: false
mutect_max_alt_allele_in_normal_fraction: 0.1
mutect_max_alt_alleles_in_normal_count: 5
varscan_strand_filter: 1
varscan_min_var_freq: 0.08
varscan_p_value: 0.1
varscan_max_normal_freq: 0.1
pindel_insert_size: 400
docm_vcf:
  class: File
  path: $DOCM
vep_cache_dir: $VEPCACHE
synonyms_file:
  class: File
  path: $SYNONYMS
coding_only: true
hgvs_annotation: true
variants_to_table_fields: [CHROM,POS,ID,REF,ALT,set]
variants_to_table_genotype_fields: [GT,AD]
vep_to_table_fields: [Allele,Consequence,SYMBOL,Feature,HGVSc,HGVSp]
EOF
