# Makefile
sentinel/static/bundle.js: clean
	webpack --config webpack.prod.config.js

clean:
	rm -rf sentinel/static/bundle.js

.PHONY: clean
