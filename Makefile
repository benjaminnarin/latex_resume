# Builds with a local TeX install if latexmk is on PATH, otherwise in a
# container built from ./Dockerfile. Force the container with
# `make USE_DOCKER=1`; switch runtime with `make DOCKER=podman`.
DOCKER ?= docker
IMAGE  ?= latex-resume

ifeq ($(USE_DOCKER)$(shell command -v latexmk),)
USE_DOCKER = 1
endif

ifdef USE_DOCKER
IMAGE_DEP = .image
RUN = $(DOCKER) run --rm -v "$(CURDIR)":/work -w /work -e HOME=/tmp \
      -u $(shell id -u):$(shell id -g) $(IMAGE)
endif

.PHONY: all watch clean image

all: resume.pdf

resume.pdf: resume.tex $(IMAGE_DEP)
	$(RUN) latexmk resume.tex

# Rebuild automatically whenever resume.tex is saved (Ctrl+C to stop).
watch: $(IMAGE_DEP)
	$(RUN) latexmk -pvc -view=none resume.tex

clean: $(IMAGE_DEP)
	$(RUN) latexmk -C

# Build the container image; the stamp file reruns this only when the
# Dockerfile changes. `make image` forces a rebuild.
.image: Dockerfile
	$(DOCKER) build -t $(IMAGE) .
	touch $@

image:
	$(DOCKER) build -t $(IMAGE) .
	touch .image
