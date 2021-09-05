class Snippet::ScopePath < Snippet::Scope
  # Properties
  property paths : Array(String)

  # Creates a new instance.
  def initialize(@paths)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    @paths.any? do |pattern|
      # https://github.com/crystal-lang/crystal/issues/11014
      File.match?(pattern, path.to_s)
    end
  end
end
