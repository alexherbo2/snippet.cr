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
snippets edit
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
snippets get input_paths
snippets get output_path
snippets get files
snippets get all
snippets get snippets crystal
snippets get snippet crystal def
```

## Credits

- [dscottboggs]
- [Blacksmoke16]

[dscottboggs]: https://github.com/dscottboggs
[Blacksmoke16]: https://github.com/Blacksmoke16
