# Snippets

An editor agnostic command-line tool for snippets.

## Dependencies

- [Crystal]

[Crystal]: https://crystal-lang.org

## Installation

``` sh
make install
```

### Editor integration

- [Kakoune][snippets.kak]

[snippets.kak]: https://github.com/alexherbo2/snippets.kak

## Usage

```
snippets build [--watch] [directory...]
snippets edit [--editor=COMMAND]
snippets show
snippets get input_paths
snippets get output_path
snippets get files
snippets get all
snippets get snippets [scope...]
snippets get snippet [scope...] [name]
```

## Examples

``` sh
snippets build
snippets edit
snippets show
snippets get input_paths
snippets get output_path
snippets get files
snippets get all
snippets get snippets crystal
snippets get snippet crystal def
```

**Example** – Show snippets:

``` sh
snippets show
```

See the output [here][`snippets.txt`].

[`snippets.txt`]: https://gist.github.com/alexherbo2/d6351c92996d0ce2ead82cb35a91250f/raw/snippets.txt

**Example** – Get snippets:

``` sh
snippets get all
```

See the output [here][`snippets.json`].

[`snippets.json`]: https://gist.github.com/alexherbo2/d6351c92996d0ce2ead82cb35a91250f/raw/snippets.json

**Example** – Copy to clipboard with [fzf] and [Alacritty] using [wl-clipboard]:

`~/.local/bin/snippets-to-clipboard`

``` sh
#!/bin/sh

alacritty --class 'Alacritty · Floating' --command sh -c '
  setsid wl-copy --trim-newline < $(
    snippets get files |
    jq --raw-output .[] |
    fzf --preview-window=down:60% --preview "cat {}" --prompt="(s)>"
  )
'
```

[fzf]: https://github.com/junegunn/fzf
[Alacritty]: https://github.com/alacritty/alacritty
[wl-clipboard]: https://github.com/bugaevc/wl-clipboard

## Credits

- [dscottboggs]
- [Blacksmoke16]

[dscottboggs]: https://github.com/dscottboggs
[Blacksmoke16]: https://github.com/Blacksmoke16
