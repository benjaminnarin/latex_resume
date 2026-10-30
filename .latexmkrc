# Shared by make, CI, and editor integrations (e.g. VS Code LaTeX Workshop)
# so a bare `latexmk` does the right thing. pdflatex is required:
# resume.tex uses \pdfgentounicode for machine-readable (ATS-friendly) text.
$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
