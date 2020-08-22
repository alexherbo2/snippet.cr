require "json"

module Snippets::Structs
  # Snippet
  record(Snippet, scope : String, name : String, content : String) do
    include JSON::Serializable
  end

  # Access a snippet by its name.
  # snippets[name] ⇒ snippet
  alias HashSnippets = Hash(String, Snippet)

  # Access snippets by their scope name.
  # snippets[scope][name] ⇒ snippet
  alias HashScopes = Hash(String, HashSnippets)
end
