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

The default location for snippets are `~/.local/share/scr/snippets`.

## Options

- `-v`, `--version` ⇒ Display version
- `-h`, `--help` ⇒ Show help
- `--` ⇒ Stop handling options
- `-` ⇒ Stop handling options and read stdin

## Commands

###### `select`

**Options**

- `-P`, `--path <path>` ⇒ File path

Select snippets.

###### `help`

Show help.

###### `version`

Display version.
