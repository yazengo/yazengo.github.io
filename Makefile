
# set a list of txt files
TXT = $(wildcard txt/tech/*.txt txt/life/*.txt)

# make a list of html files
TEMP = $(patsubst %.txt, %.temp, $(TXT))
HTML = $(patsubst %.txt, %.html, $(TXT))

all: $(HTML) index.html

index.html: stylesheets/main.css
	firefox index.html

%.temp: %.txt
	perl Markdown_1.0.1/Markdown.pl $< > $@

%.html: %.temp html/header.html html/footer.html
	cat html/header.html $< html/footer.html > $@

clean:
	rm $(TEMP)
