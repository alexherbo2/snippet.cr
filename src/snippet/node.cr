require "json"

struct Snippet::Node
  include JSON::Serializable

  # Properties
  property snippets = [] of Snippet
  property scopes = [] of Scope
  property children = [] of Node

  def initialize
  end

  def add(node : Node)
    @children.push(node)
  end

  def select(path : Path | String, prefix : String)
    self.select(path).select(&.name.starts_with?(prefix))
  end

  def select(path : Path)
    snippets = [] of Snippet

    in_scope = @scopes.all? do |scope|
      scope.call(path)
    end

    if in_scope
      snippets.concat(@snippets)
      @children.each do |child|
        snippets.concat(child.select(path))
      end
    end

    snippets
  end

  def select(path : String)
    self.select(Path[path])
  end
end
