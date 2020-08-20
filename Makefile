build:
	shards build --release

install: build
	mkdir -p ~/.local/bin
	ln -sf "${PWD}/bin/snippets" ~/.local/bin

	# Install snippets
	mkdir -p ~/.config/snippets
	test -e ~/.config/snippets/base || ln -s "${PWD}/snippets" ~/.config/snippets/base

uninstall:
	rm -f ~/.local/bin/snippets

clean:
	rm -Rf bin
