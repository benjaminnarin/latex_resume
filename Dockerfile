# Minimal TeX environment matching the local apt install, used by
# `make USE_DOCKER=1` (or automatically when latexmk isn't installed).
FROM ubuntu:26.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      latexmk texlive-latex-extra texlive-fonts-recommended \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
