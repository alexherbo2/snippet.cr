class Snippet::ScopeExtension < Snippet::Scope
  # Properties
  property extensions : Array(String)

  # Creates a new instance.
  def initialize(@extensions)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    @extensions.includes?(path.extension)
  end
end
