require "json"

abstract class Snippet::Scope
  include JSON::Serializable

  # Evaluates the scope of a snippet.
  abstract def call(path : Path)

  def call(path : String)
    call(Path[path])
  end
end
