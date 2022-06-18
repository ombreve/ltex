.POSIX:
.SUFFIXES:

TEX     = tex
INITEX  = $(TEX) -ini -enc
DVIPS   = dvips
PSPDF   = ps2pdf
PREFIX  = ${HOME}/Library/texmf
FMTDIR  = $(PREFIX)/web2c

format = lplain.fmt
source = $(format:.fmt=.tex)

$(format): $(source)
	$(INITEX) $(source)

test : test.pdf

test.pdf : test.tex $(format)
	$(TEX) -fmt ./$(format) $<
	$(DVIPS) test.dvi
	$(PSPDF) test.ps

clean:
	rm -f $(format) *.dvi *.log *.ps

distclean: clean
	rm -f *.pdf

install: $(format)
	mkdir -p $(FMTDIR)
	install -m 644 $(format) $(FMTDIR)

uninstall:
	rm -f $(FMTDIR)/$(format)

