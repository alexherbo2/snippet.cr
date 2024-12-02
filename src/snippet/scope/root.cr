class Snippet::ScopeRoot < Snippet::Scope
  # Properties
  property roots : Array(String)

  # Creates a new instance.
  def initialize(@roots)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    path.parents.any? do |parent|
      @roots.any? do |root|
        File.exists?(parent / root)
      end
    end
  end
end
