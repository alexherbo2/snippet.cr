build:
	shards build --release

install: build
	# Install bin/snippets
	install -d ~/.local/bin
	install bin/snippets ~/.local/bin
	# Install share/snippets
	install -d ~/.local/share
	rm -Rf ~/.local/share/snippets
	cp -R share/snippets ~/.local/share
	# Install support
	bin/snippets install

uninstall:
	rm -Rf ~/.local/bin/snippets ~/.local/share/snippets

clean:
	rm -Rf bin
