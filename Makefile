
# set a list of txt files
TXT = $(wildcard txt/tech/*.txt txt/life/*.txt)

# make a list of html files
TEMP = $(patsubst %.txt, %.body, %.header $(TXT))
HTML = $(patsubst %.txt, %.html, $(TXT))

all: $(HTML) index.html

index.html: index/header.html index/body.html index/footer.html 
	cat $^ > $@

index/body.html: $(TXT) index/index_body.py
	python index/index_body.py > $@

%.body: %.txt
	perl Markdown_1.0.1/Markdown.pl $< > $@

%.header: %.txt
	python html/html_header.py $< > $@

%.html: %.header %.body html/footer.html
	cat $^ > $@

clean:
	rm $(TEMP)
