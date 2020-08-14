# Snippets

An editor agnostic command-line tool for snippets.

## Dependencies

- [Crystal]

[Crystal]: https://crystal-lang.org

## Installation

``` sh
make install
```

## Usage

```
snippets build [directory...]
snippets get path
snippets get all
snippets get snippets [scope...]
snippets get snippet [scope...] [name]
```

## Examples

``` sh
snippets build snippets
snippets get path
snippets get all
snippets get snippets crystal
snippets get snippet crystal def
```

## Credits

- [dscottboggs]
- [Blacksmoke16]

[dscottboggs]: https://github.com/dscottboggs
[Blacksmoke16]: https://github.com/Blacksmoke16
