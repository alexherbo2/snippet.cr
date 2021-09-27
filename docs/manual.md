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

Install [snippets][built-in snippets].

[Built-in snippets]: ../share/scr/snippets

###### `select`

**Options**

- `-P`, `--path <path>` ⇒ File path

Select snippets.

###### `insert`

**Options**

- `-P`, `--prefix <value>` ⇒ Use the given prefix
- `-T`, `--tab` ⇒ Use a tab for each indentation level instead of two spaces
- `-I`, `--indent <number>` ⇒ Use the given number of spaces for indentation

Insert snippets.

###### `help`

Show help.

###### `version`

Display version.

## Environment variables

- `SCR_CONFIG`: Specifies the path to the configuration directory (Default: `~/.config/scr/snippets`)
- `SCR_RUNTIME`: Location of the runtime path (Default: `../share/scr` relative to the `scr` binary directory)
