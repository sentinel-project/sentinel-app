# Makefile
sentinel/static/: clean
	npm run build:prod

clean:
	rm -rf dist

.PHONY: clean
