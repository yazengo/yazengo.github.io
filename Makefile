
# set a list of txt files
TXT = $(wildcard txt/tech/*.txt txt/life/*.txt)

# make a list of html files
TEMP_HEADER = $(patsubst %.txt, %.header, $(TXT))
TEMP_BODY = $(patsubst %.txt, %.body, $(TXT))
HTML = $(patsubst %.txt, %.html, $(TXT))

.PHONY: all
all: $(HTML) index.html

index.html: index/header.html index/body.html index/footer.html 
	cat $^ > $@

index/body.html: $(TXT) index/index_body.py
	python index/index_body.py > $@

%.body: %.txt
	txt/tech/mdinclude $< temp
	perl Markdown_1.0.1/Markdown.pl temp > $@
	rm temp

%.header: %.txt
	python html/html_header.py $< > $@

%.html: %.header %.body html/footer.html
	cat $^ > $@

.PHONY: clean
clean:
	rm -rf $(TEMP_HEADER)
	rm -rf $(TEMP_BODY)
	rm -rf $(HTML)
