clean_vimscript.html: README.md
	markdown_py README.md > clean_vimscript.html

.PHONY: clean
clean:
	rm -f clean_vimscript.html
