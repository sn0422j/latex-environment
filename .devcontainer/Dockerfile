FROM paperist/texlive-ja:latest
RUN apt-get update \
  && apt-get install -y \
    libfontconfig1 git \
  && rm -rf /var/lib/apt/lists/*
RUN tlmgr update --self && tlmgr install \
  biblatex \
  biber \
  biblatex-apa \
  upmendex \
  latexdiff
