build:
	shards build --release

install: build
	mkdir -p ~/.local/bin
	ln -sf "${PWD}/bin/snippets" ~/.local/bin

uninstall:
	rm -f ~/.local/bin/snippets

clean:
	rm -Rf bin
