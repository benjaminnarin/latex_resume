# LaTeX Resume

Source for my resume: `resume.tex` (compiled with pdflatex).

## Local build

Uses a local TeX install if `latexmk` is on your PATH; otherwise falls back to
a container built from `Dockerfile` (same apt packages as the local install
below), so nothing beyond `make` + Docker/Podman is required.

```sh
make        # builds resume.pdf
make watch  # rebuilds on every save of resume.tex
make clean  # removes build output
```

Options: `make USE_DOCKER=1` forces the container build, `make DOCKER=podman`
switches runtime, `make image` rebuilds the image. The image is built once on
first use and again only when `Dockerfile` changes.

To install TeX locally instead (Debian/Ubuntu):

```sh
sudo apt install latexmk texlive-latex-extra texlive-fonts-recommended
```

Build settings live in `.latexmkrc`, so editor plugins such as VS Code's
LaTeX Workshop pick them up automatically.

## Cloud build

GitHub Actions compiles the resume on pushes to `main` and on pull requests.
Download `Benjamin_Narin_Resume.pdf` from the **resume** artifact on the workflow run.

To publish a version, push a tag; the PDF is attached to a GitHub Release:

```sh
git tag v2026.10 && git push origin v2026.10
```

Every push to `main` also refreshes a rolling **latest** prerelease, so this
link always serves the current PDF:

<https://github.com/benjaminnarin/latex_resume/releases/download/latest/Benjamin_Narin_Resume.pdf>
