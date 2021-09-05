require "./node"
require "./snippet"
require "./scope"

module Snippet::Directory
  extend self

  def read(path : Path)
    node = Node.new

    # Path entries
    paths = Dir.children(path).map do |child|
      path / child
    end

    # Creates snippet tree
    paths.each do |path|
      if path.basename == "scope.yml"
        node.scopes = FileScope.read(path)
      elsif File.file?(path)
        node.snippets << FileSnippet.read(path)
      elsif File.directory?(path)
        node.add(read(path))
      end
    end

    node
  end
end
