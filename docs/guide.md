# Guide

## Command-line interface

See the [manual].

[Manual]: manual.md

## Built-in snippets

snippet.cr has [built-in snippets] for a number of languages.

[Built-in snippets]: ../share/scr/snippets

## Install snippets from the Marketplace

Just drop snippets in your `~/.config/scr/snippets` folder.

## Create your own snippets

Each snippet is defined under a snippet name and has a content and scope.

To create your first snippet, open `~/.config/scr/snippets/crystal/def`:

```
def {{name}}
	{{content}}
end
```

In the example above:

- The name of the snippet is the file name `def`.
- The content of the snippet is the file content.
- `{{name}}` and `{{content}}` are placeholders.
- Embedded tabs will be formatted according to the context in which the snippet is inserted.

In JSON, it would be represented as:

```
{ "name": "def", "content": "def..." }
```

## Snippet scope

Snippets are scoped so that only relevant snippets are suggested.

Snippets can be scoped by either:

- `global` ⇒ a boolean: `true` or `false`.
- `roots` ⇒ a list of roots to match, such as: `[".git"]`.
- `paths` ⇒ a list of paths to match, such as: `["**/spec/*_spec.cr"]`.
- `extensions` ⇒ a list of extensions to match, such as: `[".cr"]`.

If the scope is omitted, the snippet gets applied to all languages.

To create your first scope, open `~/.config/scr/snippets/crystal/scope.yml`:

``` yaml
extensions: [".cr"]
```

Add a second snippet and its scope for testing:

`~/.config/scr/snippets/crystal/spec/describe`

```
describe {{description}} do
	{{content}}
end
```

`~/.config/scr/snippets/crystal/spec/scope.yml`

``` yaml
paths: ["**/spec/*_spec.cr"]
```

Snippets are hierarchical, which means you can organize them as a tree:

``` yaml
- rails
  - ruby
    - model
    - controller
  - eruby
    - view
```

and with the following scopes:

`rails/scope.yml`

``` yaml
roots: ["config/environment.rb"]
```

`rails/ruby/scope.yml`

``` yaml
extensions: [".rb"]
```

`rails/ruby/model/scope.yml`

``` yaml
paths: ["**/app/models/*.rb"]
```

`rails/ruby/controller/scope.yml`

``` yaml
paths: ["**/app/controllers/*_controller.rb"]
```

`rails/eruby/scope.yml`

``` yaml
extensions: [".erb"]
```

`rails/eruby/view/scope.yml`

``` yaml
paths: ["**/app/views/*/*.html.erb"]
```

## Snippet syntax
## Common questions
