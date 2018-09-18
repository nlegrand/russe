# This Makefile generates a RTL booklet (livret.pdf) from the TeX
# source russe.tex which generates a a5 document.
#
# The process steps are written from the end to the beginning, so if
# you want to follow each step, you may start at the end of the
# document, skiping the clean target.

# Convert the ps booklet in pdf
livret.pdf: livret.ps
	ps2pdf livret.ps livret.pdf

# Put all a5 pages on a4 sheets, the booklet is done, in ps
livret.ps: rtl.ps
	psnup -2 -pa4 -Pa5 rtl.ps livret.ps

# Reverse the order of the booklet to have a RTL document
rtl.ps: book.ps
	pstops 1:-0 book.ps rtl.ps

# Sort the pages so you can print a booklet
book.ps: russe.ps
	psbook russe.ps book.ps

# psutils works on ps files, so convert pdf to ps
russe.ps: russe.pdf
	pdftops russe.pdf

# create the pdf
russe.pdf: russe.tex
	xelatex russe.tex

clean:
	rm -f livret.ps rtl.ps book.ps russe.ps russe.pdf livret.pdf russe.log russe.aux *~
