require "walk"

class Snippet::ScopeRoot < Snippet::Scope
  # Properties
  property roots : Array(String)

  # Creates a new instance.
  def initialize(@roots)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    Walk::Up.new(path).any? do |directory|
      @roots.any? do |root|
        File.exists?(directory / root)
      end
    end
  end
end
