class Snippet::ScopePath < Snippet::Scope
  # Properties
  property paths : Array(String)

  # Creates a new instance.
  def initialize(@paths)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    @paths.any? do |pattern|
      File.match?(pattern, path)
    end
  end
end
