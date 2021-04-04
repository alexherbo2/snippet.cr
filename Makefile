build:
	shards build --release

install: build
	install -d ~/.local/bin
	ln -sf ${PWD}/bin/snippets ~/.local/bin
	bin/snippets install

uninstall:
	rm -f ~/.local/bin/snippets

clean:
	rm -Rf bin
