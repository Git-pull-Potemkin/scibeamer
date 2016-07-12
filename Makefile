NAME=scibeamer

default: pdf
all: dvi eps pdf
dvi: $(NAME).dvi
eps: $(NAME).eps
pdf: $(NAME).pdf

view: view-pdf
#view: view-dvi
#view: view-eps

edit: $(NAME).tex Makefile
	$(EDITOR) $^

upload: $(NAME).pdf
	scp $< adc@fh.cs.au.dk:~/public_html_cs/

$(NAME).eps: $(NAME).dvi
	dvips -o $@ $<

#$(NAME).pdf: $(NAME).dvi
#	#ps2pdf $< $@
#	dvipdfm $<

#$(NAME).pdf: $(NAME).eps
#	#ps2pdf $< $@
#	epstopdf $<

$(NAME).dvi: *.tex
	#sh ./epstopdf.sh pdflatex $(NAME).tex
	latex $(NAME).tex
	bibtex $(NAME).aux
	latex $(NAME).tex
	latex $(NAME).tex

$(NAME).pdf: $(NAME).aux
	pdflatex $(NAME).tex

$(NAME).bbl: $(NAME).aux
	bibtex $(NAME).aux
	pdflatex $(NAME).tex

$(NAME).aux: $(NAME).tex graphics/*
	pdflatex $(NAME).tex

view-pdf: $(NAME).pdf
	open $< ; xdg-open $< &

view-dvi: $(NAME).dvi
	xdvi -background white -foreground black $< &

view-eps: $(NAME).eps
	gv $< &

clean:
	$(RM) $(NAME).pdf
	$(RM) $(NAME).log
	$(RM) $(NAME).toc
	$(RM) $(NAME).out
	$(RM) $(NAME).aux
	$(RM) $(NAME).bbl
	$(RM) $(NAME).blg
	$(RM) $(NAME).eps
	$(RM) $(NAME).dvi
	$(RM) $(NAME).nav
	$(RM) $(NAME).snm
	$(RM) $(NAME).vrb
