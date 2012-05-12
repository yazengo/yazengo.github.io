
all: html/test.html

html/test.html: html/header.html html/1.html html/footer.html
	cat $^ > $@

html/%.html: tech/%.txt 
	perl Markdown_1.0.1/Markdown.pl $< > $@
