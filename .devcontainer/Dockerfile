FROM paperist/texlive-ja:latest
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libfontconfig1 \
    git \
    pandoc \
  && rm -rf /var/lib/apt/lists/*

RUN tlmgr update --self \
  && tlmgr install \
    latexmk \
    biblatex \
    biber \
    biblatex-apa \
    upmendex \
    latexdiff
