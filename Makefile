PAPER=working
BIBLIOGRAPHY=lib.bib
#TEMPLATE=templates/elsarticle-template-1-num.latex
TEMPLATE=templates/scientific_reports.latex
PANDOC=pandoc
USE_NATBIB=--biblatex #--natbib
MD_FILES=working.md

export TEXINPUTS=.:./templates/dependencies//:
export BIBINPUTS=.:./templates/dependencies//:


${PAPER}.pdf: ${PAPER}.tex ${BIBLIOGRAPHY}
	pdflatex ${PAPER}.tex
	bibtex ${PAPER}
	pdflatex ${PAPER}.tex

${PAPER}.tex: ${PAPER}.md ${BIBLIOGRAPHY} ${TEMPLATE}
	${PANDOC} -s --filter pandoc-fignos --filter pandoc-citeproc ${USE_NATBIB} ${PAPER}.md -o ${PAPER}.tex --template ${TEMPLATE} --bibliography ${BIBLIOGRAPHY}

watch: $(MD_FILES) $(BIBLIOGRAPHY)
	fswatch -o $^ | xargs -n1 -I{} make
