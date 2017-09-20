FROM mgibio/cle:vep_parser
MAINTAINER David Spencer <dspencer@wustl.edu>

LABEL \
    description="Image for tools used in the CLE"

WORKDIR /opt/

RUN git clone https://github.com/genome/cancer-genomics-workflow.git

COPY detect_variants_yml.sh ./


