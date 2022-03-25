FROM toshiara/alpine-texlive-ja
RUN apk add git

RUN tlmgr update --self && tlmgr install \
    biblatex \
    biber \
    biblatex-apa
