# Manual

## Usage

**Example**

``` sh
scr select --path src/main.cr
```

Returns matched snippets in JSON.

```
[
  { "name": "def", "content": "def..." },
  ...
]
```

The default location for snippets are `~/.config/scr/snippets`.

## Options

- `-v`, `--version` ⇒ Display version
- `-h`, `--help` ⇒ Show help
- `--` ⇒ Stop handling options
- `-` ⇒ Stop handling options and read stdin

## Commands

###### `install`

```
scr install <name>
```

Install files.

###### `install snippets`

```
scr install snippets
```

Install [snippets][Shipped snippets].

[Shipped snippets]: ../share/scr/snippets

###### `select`

**Options**

- `-P`, `--path <path>` ⇒ File path

Select snippets.

###### `help`

Show help.

###### `version`

Display version.
