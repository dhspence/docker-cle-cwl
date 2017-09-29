FROM mgibio/cle:v1.0.0
MAINTAINER David Spencer <dspencer@wustl.edu>

LABEL \
    description="Image for tools used in the CLE"

WORKDIR /opt/

RUN git clone https://github.com/genome/cancer-genomics-workflow.git

COPY detect_variants_yml.sh ./


